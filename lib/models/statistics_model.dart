// To parse this JSON data, do
//
//     final statisticsModel = statisticsModelFromJson(jsonString);

import 'dart:convert';

StatisticsModel statisticsModelFromJson(String str) =>
    StatisticsModel.fromJson(json.decode(str));

String statisticsModelToJson(StatisticsModel data) =>
    json.encode(data.toJson());

class StatisticsModel {
  int? statusCode;
  int? users;
  int? clients;
  int? vouchers;
  int? orders;
  int? shipments;
  int? canceledShipments;
  int? completedShipments;
  int? receivedShipments;
  int? sites;
  int? locations;
  int? items;
  int? categories;
  int? stock;

  StatisticsModel({
    this.statusCode,
    this.users,
    this.clients,
    this.vouchers,
    this.orders,
    this.shipments,
    this.canceledShipments,
    this.completedShipments,
    this.receivedShipments,
    this.sites,
    this.locations,
    this.categories,
    this.items,
    this.stock,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
        statusCode: json["statusCode"],
        users: json["users"],
        clients: json["clients"],
        vouchers: json["vouchers"],
        orders: json["orders"],
        shipments: json["shipments"],
        canceledShipments: json["canceledShipments"],
        completedShipments: json["completedShipments"],
        receivedShipments: json["receivedShipments"],
        sites: json["sites"],
        locations: json["locations"],
        items: json["items"],
        categories: json["categories"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "users": users,
        "clients": clients,
        "vouchers": vouchers,
        "orders": orders,
        "shipments": shipments,
        "canceledShipments": canceledShipments,
        "completedShipments": completedShipments,
        "receivedShipments": receivedShipments,
        "stock": stock,
      };
}
