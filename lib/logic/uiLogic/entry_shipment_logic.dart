import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';

import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/clients_model.dart';
import '../services/api_manager.dart';

class EntryShipmentLogic {
  late BuildContext context;
  late WidgetRef ref;

  final clientProvider = StateProvider<Client?>((ref) => null);
  final clientNameProvider = StateProvider<String?>((ref) => null);
  final arrivalDateProvider = StateProvider<String?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  static List<Map> children = [];

  TextEditingController containerCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();

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
            arrivalDate: ref.read(arrivalDateProvider.notifier).state ?? "",
            container: containerCnt.text,
            description: descriptionCnt.text,
            items: children)
        .then((value) {
      Navigator.pop(context);
      if (value['statusCode'] == 200) {
        navigator(
            context: context,  replacement: true, screen: Shipments());
      } else {
        Dialogs().messageDialog(context, value['message']);
      }
    });
  }
}
