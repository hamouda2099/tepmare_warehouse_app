import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/config/user_data.dart';
import 'package:tepmare_warehouse_man_app/logic/services/cache_manager.dart';
import 'package:tepmare_warehouse_man_app/ui/components/bottom_bar.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/categories.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/items.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/locations.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/login.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipments.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/sites.dart';

import '../../logic/services/api_manager.dart';
import '../../models/statistics_model.dart';
import '../components/dashboard_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 35,
                      height: 35,
                    ),
                    10.w,
                     Text(
                      "Dashboard".tr(),
                      style: TextStyle(
                          color: kGreyColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                20.h,
                FutureBuilder<StatisticsModel>(
                  future: ApiManager.getStatistics(),
                  builder: (BuildContext context,
                      AsyncSnapshot<StatisticsModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return const Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                            color: kSecondaryColor,
                          )));
                        }
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else {
                          return Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      navigator(context: context, screen:Sites());
                                    },
                                    child: DashboardCard(
                                      icon: 'assets/images/sites.png',
                                      color: kSecondaryColor,
                                      label: "Sites".tr(),
                                      data: snapshot.data?.sites.toString(),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      navigator(context: context, screen: Locations());
                                    },
                                    child: DashboardCard(
                                      icon: 'assets/images/locations.png',
                                      color: kPrimaryColor,
                                      label: "Locations".tr(),
                                      data: snapshot.data?.locations.toString(),
                                    ),
                                  ),
                                ],
                              ),
                              10.h,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      navigator(context: context, screen:Categories());
                                    },
                                    child: DashboardCard(
                                      icon: 'assets/images/category.png',
                                      color: Colors.deepPurple,
                                      label: "Categories".tr(),
                                      data: snapshot.data?.categories.toString(),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      navigator(context: context, screen:Items());
                                    },
                                    child: DashboardCard(
                                      icon: 'assets/images/items.png',
                                      color: kGreenColor,
                                      label: "Items".tr(),
                                      data: snapshot.data?.items.toString(),
                                    ),
                                  ),
                                ],
                              ),
                              10.h,
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      navigator(context: context, screen: Shipments());
                                    },
                                    child: DashboardCard(
                                      icon: 'assets/images/shipments.png',
                                      color: Colors.orange,
                                      label: "Shipments".tr(),
                                      data: snapshot.data?.shipments.toString(),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          );
                        }
                    }
                  },
                ),
                Spacer(),
                BottomBar(),
              ],
            )),
      ),
    );
  }
}
