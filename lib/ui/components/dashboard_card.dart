import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

import '../../config/constants.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({this.icon, this.color, this.data, this.label});

  Color? color;
  String? icon;
  String? label;
  String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth / 2.2,
      height: screenHeight /5.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon ?? "",
            width: 30,
            height: 30,
            color: Colors.white.withOpacity(0.4),
          ),
          5.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      label ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/double_arrow.png",
                width: 25,
                height: 25,
                color: Colors.white,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
