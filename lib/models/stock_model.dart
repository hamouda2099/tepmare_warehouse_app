// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) => StockModel.fromJson(json.decode(str));

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
    stock: json["stock"] == null ? [] : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x.toJson())),
  };
}

class Stock {
  int? id;
  int? qty;
  String? location;
  String? designation;

  Stock({
    this.id,
    this.qty,
    this.location,
    this.designation,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    id: json["id"],
    qty: json["qty"],
    location: json["location"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
    "location": location,
    "designation": designation,
  };
}
