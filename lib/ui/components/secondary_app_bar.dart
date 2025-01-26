import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';

class SecondaryAppBar extends StatelessWidget {
  SecondaryAppBar(this.label, {this.onTapIcon});
  String label;
  Function? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: kGreyColor,
            )),
        10.w,
        Text(
          label,
          style: const TextStyle(
            color: kGreyColor,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        onTapIcon == null
            ? 0.w
            : InkWell(
                onTap: () {
                  onTapIcon!();
                },
                child: const Icon(
                  Icons.add_box_rounded,
                  color: kGreenColor,
                  size: 25,
                ))
      ],
    );
  }
}
