import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/models/locations_model.dart';

import '../../config/navigator.dart';
import '../../dialogs/basic_dialogs.dart';
import '../../models/sites_model.dart';
import '../../ui/screens/locations.dart';
import '../functions/show_snack_bar.dart';
import '../services/api_manager.dart';


class CreateLocationLogic {
  late BuildContext context;
  late WidgetRef ref;
  late String locationId;
  TextEditingController hallCnt = TextEditingController();
  TextEditingController typeCnt = TextEditingController();
  TextEditingController positionCnt = TextEditingController();

  final fieldProvider = StateProvider<String?>((ref) => null);
  final aisleProvider = StateProvider<String?>((ref) => null);
  final levelProvider = StateProvider<String?>((ref) => null);
  final siteProvider = StateProvider<Site?>((ref) => null);
  final siteNameProvider = StateProvider<String?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  List aisles = ["A", "B", "C", "D", "E", "F"];
  List fields = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  List levels = ["1", "2", "3", "4"];

  void init(Location location){
    hallCnt.text = location.hall??"";
    typeCnt.text = location.type??"";
    positionCnt.text = location.position??"";
    WidgetsBinding.instance.addPostFrameCallback((callback){
      ref.read(aisleProvider.notifier).state = location.aisle??"";
      ref.read(fieldProvider.notifier).state = location.field??"";
      ref.read(levelProvider.notifier).state = location.level??"";
      ref.read(siteNameProvider.notifier).state = location.site??"";
    });
  }

  void create() {
    if (formKey.currentState!.validate()) {
      Dialogs().loadingDialog(context);
      ApiManager.createLocation(
        hall: hallCnt.text,
        position: positionCnt.text,
        type: typeCnt.text,
        aisle: ref.read(aisleProvider.notifier).state,
        level: ref.read(levelProvider.notifier).state,
        siteId: ref.read(siteProvider.notifier).state?.id.toString(),
        field: ref.read(fieldProvider.notifier).state,
      ).then((value) {
        Navigator.pop(context);
        if (value['statusCode'] == 200) {
          navigator(context: context, screen: Locations());
        } else {
          showSnackBar(
              context: context,
              message: value['message'] ?? 'Error !',
              error: true);
        }
      });
    }
  }

  void edit() {

      Dialogs().loadingDialog(context);
      ApiManager.createLocation(
        hall: hallCnt.text,
        position: positionCnt.text,
        type: typeCnt.text,
        aisle: ref.read(aisleProvider.notifier).state,
        level: ref.read(levelProvider.notifier).state,
        siteId: ref.read(siteProvider.notifier).state?.id.toString(),
        field: ref.read(fieldProvider.notifier).state,
      ).then((value) {
        Navigator.pop(context);
        if (value['statusCode'] == 200) {
          navigator(context: context, screen: Locations());
        } else {
        showSnackBar(
            context: context,
            message: value['message'] ?? 'Error !',
            error: true);
      }
    });
    }
}
