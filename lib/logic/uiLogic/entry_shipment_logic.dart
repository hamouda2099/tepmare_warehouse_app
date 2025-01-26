import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/logic/functions/show_snack_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';

import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/clients_model.dart';
import '../../ui/paginations/entry_shipments_client_items_pagination.dart';
import '../services/api_manager.dart';

class EntryShipmentLogic {
  late BuildContext context;
  late WidgetRef ref;
  final clientProvider = StateProvider<Client?>((ref) => null);
  final clientNameProvider = StateProvider<String?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  static List<Map> children = [];
  PageController controller = PageController();
  TextEditingController searchCnt = TextEditingController();
  final refreshReBuilder = StateProvider<String?>((ref) => null);
  TextEditingController containerCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();
  TextEditingController arrivalDateCnt = TextEditingController();

  Future scanItem() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      ApiManager.getItemByBarcode(barcode: barcodeScanRes).then((item) {
        if (item['statusCode'] == 200) {
          enterQty(context, itemName: item['item']['designation'])
              .then((value) {
            EntryShipmentLogic.children.add({
              "itemId": item['item']['id'],
              "qty": value,
              "designation": item['item']['designation'],
            });
          });
        } else {
          showSnackBar(
              context: context, message: "Item Not Found".tr(), error: true);
        }
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void create() {
    if (children.isEmpty) {
      return Dialogs().messageDialog(context, "at least add one item");
    }

    if (ref.read(clientProvider.notifier).state == null) {
      return Dialogs().messageDialog(context, "Please choose  client");
    }

    Dialogs().loadingDialog(context);
    ApiManager.createEntryShipment(
            clientId:
                ref.read(clientProvider.notifier).state?.id.toString() ?? "",
            arrivalDate: arrivalDateCnt.text,
            container: containerCnt.text,
            description: descriptionCnt.text,
            items: children)
        .then((value) {
      Navigator.pop(context);
      if (value['statusCode'] == 200) {
        navigator(context: context, replacement: true, screen: Shipments());
      } else {
        Dialogs().messageDialog(context, value['message']);
      }
    });
  }
}
