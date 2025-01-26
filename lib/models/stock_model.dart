// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  int? statusCode;
  String? message;
  List<Stock>? stock;

  StockModel({
    this.statusCode,
    this.message,
    this.stock,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    statusCode: json["statusCode"],
    message: json["message"],
        stock: json["stock"] == null
            ? []
            : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
        "stock": stock == null
            ? []
            : List<dynamic>.from(stock!.map((x) => x.toJson())),
      };
}

class Stock {
  num? id;
  num? qty;
  num? itemId;
  num? locationId;
  String? location;
  String? designation;
  String? sku;

  Stock({
    this.id,
    this.qty,
    this.itemId,
    this.locationId,
    this.location,
    this.designation,
    this.sku,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    id: json["id"],
    qty: json["qty"],
        itemId: json["item_id"],
        locationId: json["locationId"],
        location: json["location"],
        designation: json["designation"],
        sku: json["sku"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
        "item_id": itemId,
        "locationId": locationId,
        "location": location,
        "designation": designation,
        "sku": sku,
      };
}
