import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';
import 'package:tepmare_warehouse_man_app/config/margin.dart';
import 'package:tepmare_warehouse_man_app/config/navigator.dart';
import 'package:tepmare_warehouse_man_app/models/shipments_model.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/edit_shipment.dart';
import 'package:tepmare_warehouse_man_app/ui/screens/shipment_details.dart';

class ShipmentItem extends StatelessWidget {
  ShipmentItem(this.shipment);
  Shipment shipment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(
          context: context,
          screen: ShipmentDetails(
            shipment.id.toString(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${shipment.client?.firstName ?? ""} ${shipment.client?.lastName ?? ""}",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        shipment.arrivalDate ?? "",
                        style: const TextStyle(
                          color: kGreyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    shipment.status ?? "",
                    style: TextStyle(
                      color: shipment.status == 'new'
                          ? kGreenColor
                          : shipment.status == 'preparing'
                              ? Colors.orange
                              : kSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.w,
                  Text(
                    shipment.type ?? "",
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.w,
                  InkWell(
                      onTap: () {
                        navigator(
                          context: context,
                          screen: EditShipment(shipment),
                        );
                      },
                      child: Image.asset(
                        "assets/images/pen-circle.png",
                        width: 25,
                      )),
                ],
              ),
            ),
            10.h,
            const Divider()
          ],
        ),
      ),
    );
  }
}
