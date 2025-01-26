import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';

import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/clients_model.dart';
import '../../ui/paginations/exit_shipments_client_items_pagination.dart';
import '../services/api_manager.dart';

class ExitShipmentLogic {
  late BuildContext context;
  late WidgetRef ref;

  final clientProvider = StateProvider<Client?>((ref) => null);
  final clientNameProvider = StateProvider<String?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  static List<Map> children = [];
  PageController controller = PageController();
  TextEditingController searchCnt = TextEditingController();
  final refreshReBuilder = StateProvider<String?>((ref) => null);

  TextEditingController destinationAddressCnt = TextEditingController();
  TextEditingController approClientCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();

  Future scanItem() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      ApiManager.getStockByBarcode(barcode: barcodeScanRes).then((item) {
        if (item['statusCode'] == 200) {
          enterQty(context,
                  qty: item['item']['qty'].toString(),
                  itemName: item['item']['designation'])
              .then((value) {
            ExitShipmentLogic.children.add({
              "itemId": item['item']['item_id'],
              "qty": value,
              "designation": item['item']['designation'],
              "locationId": item['item']['locationId']
            });
          });
        } else {
          Dialogs().messageDialog(context, "Item Not Found".tr());
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
    ApiManager.createExitShipment(
            clientId:
                ref.read(clientProvider.notifier).state?.id.toString() ?? "",
            approClient: approClientCnt.text,
            destinationAddress: destinationAddressCnt.text,
            description: descriptionCnt.text,
            items: children)
        .then((value) {
      Navigator.pop(context);
      if (value['statusCode'] == 200) {
        navigator(context: context, screen: Shipments(), replacement: true);
      } else {
        Dialogs().messageDialog(context, value['message']);
      }
    });
  }
}
