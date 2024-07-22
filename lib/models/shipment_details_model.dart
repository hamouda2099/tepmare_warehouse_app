// To parse this JSON data, do
//
//     final shipmentDetailsModel = shipmentDetailsModelFromJson(jsonString);

import 'dart:convert';

ShipmentDetailsModel shipmentDetailsModelFromJson(String str) =>
    ShipmentDetailsModel.fromJson(json.decode(str));

String shipmentDetailsModelToJson(ShipmentDetailsModel data) =>
    json.encode(data.toJson());

class ShipmentDetailsModel {
  int? statusCode;
  String? message;
  Shipment? shipment;

  ShipmentDetailsModel({
    this.statusCode,
    this.message,
    this.shipment,
  });

  factory ShipmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      ShipmentDetailsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        shipment: json["shipment"] == null
            ? null
            : Shipment.fromJson(json["shipment"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "shipment": shipment?.toJson(),
      };
}

class Shipment {
  int? id;
  int? clientId;
  String? type;
  String? status;
  DateTime? arrivalDate;
  String? container;
  String? description;
  dynamic destinationAddress;
  dynamic nDApproClient;
  String? createdAt;
  dynamic deletedAt;
  Client? client;
  List<Item>? items;

  Shipment({
    this.id,
    this.clientId,
    this.type,
    this.status,
    this.arrivalDate,
    this.container,
    this.description,
    this.destinationAddress,
    this.nDApproClient,
    this.createdAt,
    this.deletedAt,
    this.client,
    this.items,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        clientId: json["client_id"],
        type: json["type"],
        status: json["status"],
        arrivalDate: json["arrival_date"] == null
            ? null
            : DateTime.parse(json["arrival_date"]),
        container: json["container"],
        description: json["description"],
        destinationAddress: json["destination_address"],
        nDApproClient: json["n_d_appro_client"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "type": type,
        "status": status,
        "arrival_date":
            "${arrivalDate!.year.toString().padLeft(4, '0')}-${arrivalDate!.month.toString().padLeft(2, '0')}-${arrivalDate!.day.toString().padLeft(2, '0')}",
        "container": container,
        "description": description,
        "destination_address": destinationAddress,
        "n_d_appro_client": nDApproClient,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "client": client?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Client {
  int? clientId;
  String? firstName;
  String? lastName;
  String? companyName;
  String? username;
  String? email;
  String? fax;
  String? address;
  String? postalCode;
  String? villa;
  dynamic deliveryAddress;
  String? deliveryPostalCode;
  String? deliveryVilla;

  Client({
    this.clientId,
    this.firstName,
    this.lastName,
    this.companyName,
    this.username,
    this.email,
    this.fax,
    this.address,
    this.postalCode,
    this.villa,
    this.deliveryAddress,
    this.deliveryPostalCode,
    this.deliveryVilla,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        clientId: json["clientId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        companyName: json["companyName"],
        username: json["username"],
        email: json["email"],
        fax: json["fax"],
        address: json["address"],
        postalCode: json["postalCode"],
        villa: json["villa"],
        deliveryAddress: json["deliveryAddress"],
        deliveryPostalCode: json["deliveryPostalCode"],
        deliveryVilla: json["deliveryVilla"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "firstName": firstName,
        "lastName": lastName,
        "companyName": companyName,
        "username": username,
        "email": email,
        "fax": fax,
        "address": address,
        "postalCode": postalCode,
        "villa": villa,
        "deliveryAddress": deliveryAddress,
        "deliveryPostalCode": deliveryPostalCode,
        "deliveryVilla": deliveryVilla,
      };
}

class Item {
  int? id;
  int? itemId;
  int? shipmentId;
  int? reportedQty;
  num? receivedQty;
  num? locationId;
  String? type;
  String? designation;

  Item({
    this.id,
    this.itemId,
    this.shipmentId,
    this.reportedQty,
    this.receivedQty,
    this.locationId,
    this.type,
    this.designation,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemId: json["item_id"],
        shipmentId: json["shipment_id"],
        reportedQty: json["reported_qty"],
        receivedQty: json["received_qty"],
        locationId: json["location_id"],
        type: json["type"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "shipment_id": shipmentId,
        "reported_qty": reportedQty,
        "received_qty": receivedQty,
        "location_id": locationId,
        "type": type,
        "designation": designation,
      };
}
