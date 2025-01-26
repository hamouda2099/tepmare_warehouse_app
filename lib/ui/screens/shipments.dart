import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/ui/components/secondary_app_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/paginations/shipments_pagination.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/entry_shipment.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/exit_shipment.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/home.dart';

import '../components/search_text_field.dart';

class Shipments extends ConsumerWidget {
  TextEditingController searchCnt = TextEditingController();
  final refreshProvider = StateProvider<String?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SecondaryAppBar(
                "Shipments".tr(),
                onTapIcon: () {
                  navigator(
                    context: context,
                    screen: const Home(),
                    replacement: true,
                  );
                },
              ),
              20.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      navigator(
                        context: context,
                        screen: EntryShipment(),
                      );
                    },
                    child: Container(
                      width: screenWidth / 2.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Entry'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigator(
                        context: context,
                        screen: ExitShipment(),
                      );
                    },
                    child: Container(
                      width: screenWidth / 2.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Exit'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              10.h,
              Container(
                decoration: BoxDecoration(
                    color: kGreyColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(15)),
                child: SearchTextField(
                  controller: searchCnt,
                  onChanged: (val) {
                    ref.read(refreshProvider.notifier).state =
                        DateTime.now().toString();
                  },
                ),
              ),
              10.h,
              Consumer(
                builder: (context, ref, child) {
                  ref.watch(refreshProvider);

                  return Expanded(
                    child: ShipmentsPagination(
                      query: searchCnt.text,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
