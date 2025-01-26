import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/ui/paginations/stock_pagination.dart';

import '../components/search_text_field.dart';
import '../components/secondary_app_bar.dart';

class StockScreen extends ConsumerWidget {
  final refreshProvider = StateProvider<String?>((ref) => null);

  TextEditingController searchCnt = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Column(
            children: [
              SecondaryAppBar(
                "Stock".tr(),
              ),
              20.h,
              Container(
                decoration: BoxDecoration(
                  color: kGreyColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(15),
                ),
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
                    child: StockPagination(
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
