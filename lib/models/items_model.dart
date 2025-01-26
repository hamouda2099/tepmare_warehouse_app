// To parse this JSON data, do
//
//     final itemsModel = itemsModelFromJson(jsonString);

import 'dart:convert';

ItemsModel itemsModelFromJson(String str) =>
    ItemsModel.fromJson(json.decode(str));

String itemsModelToJson(ItemsModel data) => json.encode(data.toJson());

class ItemsModel {
  int? statusCode;
  String? message;
  List<Item>? items;

  ItemsModel({
    this.statusCode,
    this.message,
    this.items,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
    statusCode: json["statusCode"],
    message: json["message"],
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? id;
  String? type;
  String? designation;
  String? sku;
  String? barcode;
  String? category;
  String? description;
  String? stock;
  num? width;
  num? height;
  num? weight;
  num? depth;
  Client? client;

  Item({
    this.id,
    this.type,
    this.designation,
    this.sku,
    this.barcode,
    this.category,
    this.client,
    this.stock,
    this.description,
    this.width,
    this.weight,
    this.height,
    this.depth,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    type: json["type"],
    designation: json["designation"],
    sku: json["sku"],
    barcode: json["barcode"],
    category: json["category"],
        stock: json["stock"],
        description: json["description"],
        width: json["width"],
    weight: json["weight"],
    height: json["height"],
    depth: json["depth"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "designation": designation,
    "sku": sku,
    "barcode": barcode,
    "category": category,
        "stock": stock,
        "description": description,
        "width": width,
    "weight": weight,
    "height": height,
    "depth": depth,
    "client": client?.toJson(),
  };
}

class Client {
  num? clientId;
  String? firstName;
  String? lastName;

  Client({
    this.clientId,
    this.firstName,
    this.lastName,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["clientId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "firstName": firstName,
    "lastName": lastName,
  };
}
