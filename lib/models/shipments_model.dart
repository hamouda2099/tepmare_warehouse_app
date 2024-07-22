// To parse this JSON data, do
//
//     final shipmentsModel = shipmentsModelFromJson(jsonString);

import 'dart:convert';

ShipmentsModel shipmentsModelFromJson(String str) =>
    ShipmentsModel.fromJson(json.decode(str));

String shipmentsModelToJson(ShipmentsModel data) => json.encode(data.toJson());

class ShipmentsModel {
  int? statusCode;
  String? message;
  List<Shipment>? shipments;

  ShipmentsModel({
    this.statusCode,
    this.message,
    this.shipments,
  });

  factory ShipmentsModel.fromJson(Map<String, dynamic> json) => ShipmentsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        shipments: json["shipments"] == null
            ? []
            : List<Shipment>.from(
                json["shipments"]!.map((x) => Shipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "shipments": shipments == null
            ? []
            : List<dynamic>.from(shipments!.map((x) => x.toJson())),
      };
}

class Shipment {
  int? id;
  int? clientId;
  String? type;
  String? status;
  String? arrivalDate;
  String? container;
  String? description;
  String? destinationAddress;
  String? nDApproClient;
  String? createdAt;
  String? deletedAt;
  Client? client;

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
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        clientId: json["client_id"],
        type: json["type"],
        status: json["status"],
        arrivalDate: json["arrival_date"],
        container: json["container"],
        description: json["description"],
        destinationAddress: json["destination_address"],
        nDApproClient: json["n_d_appro_client"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "type": type,
        "status": status,
        "arrival_date": arrivalDate,
        "container": container,
        "description": description,
        "destination_address": destinationAddress,
        "n_d_appro_client": nDApproClient,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "client": client?.toJson(),
      };
}

class Client {
  int? clientId;
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
