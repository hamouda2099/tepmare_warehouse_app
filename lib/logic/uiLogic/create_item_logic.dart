import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/items.dart';

import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/categories_model.dart';
import '../../models/clients_model.dart';
import '../services/api_manager.dart';

class CreateItemLogic {
  late BuildContext context;
  late WidgetRef ref;
  final itemDetailsFormKey = GlobalKey<FormState>();
  static List<Map> children = [];
  TextEditingController designationCnt = TextEditingController();
  TextEditingController skuCnt = TextEditingController();
  TextEditingController barcodeCnt = TextEditingController();
  TextEditingController widthCnt = TextEditingController();
  TextEditingController heightCnt = TextEditingController();
  TextEditingController weightCnt = TextEditingController();
  TextEditingController depthCnt = TextEditingController();

  final typeProvider = StateProvider<String?>((ref) => null);
  final categoryProvider = StateProvider<Category?>((ref) => null);
  final categoryNameProvider = StateProvider<String?>((ref) => null);
  final clientProvider = StateProvider<Client?>((ref) => null);
  final clientNameProvider = StateProvider<String?>((ref) => null);

  List types = ['simple', 'composite'];

  void create() {
      Dialogs().loadingDialog(context);
      ApiManager.createItem(
              designation: designationCnt.text,
              sku: skuCnt.text,
              type: ref.read(typeProvider.notifier).state ?? "",
              barcode: barcodeCnt.text,
              width: widthCnt.text,
              weight: weightCnt.text,
              height: heightCnt.text,
              depth: depthCnt.text,
              clientId:
                  ref.read(clientProvider.notifier).state?.id.toString() ?? "",
              categoryId:
                  ref.read(categoryProvider.notifier).state?.id.toString() ??
                      "",
              children: children)
          .then((value) {
        Navigator.pop(context);
        if (value['statusCode'] == 200) {
          navigator(context: context, screen: Items(), replacement: true);
        } else {
          Dialogs().messageDialog(context, value['message']);
        }
      });
  }
}
