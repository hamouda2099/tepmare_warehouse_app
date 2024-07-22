import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';


import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/clients_model.dart';
import '../services/api_manager.dart';

class ExitShipmentLogic {
  late BuildContext context;
  late WidgetRef ref;

  final clientProvider = StateProvider<Client?>((ref) => null);
  final clientNameProvider = StateProvider<String?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  static List<Map> children = [];

  TextEditingController destinationAddressCnt = TextEditingController();
  TextEditingController approClientCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();

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
        navigator(
            context: context, screen: Shipments(), replacement: true);
      } else {
        Dialogs().messageDialog(context, value['message']);
      }
    });
  }
}
