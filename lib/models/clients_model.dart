// To parse this JSON data, do
//
//     final clientsModel = clientsModelFromJson(jsonString);

import 'dart:convert';

ClientsModel clientsModelFromJson(String str) =>
    ClientsModel.fromJson(json.decode(str));

String clientsModelToJson(ClientsModel data) => json.encode(data.toJson());

class ClientsModel {
  int? statusCode;
  String? message;
  List<Client>? clients;

  ClientsModel({
    this.statusCode,
    this.message,
    this.clients,
  });

  factory ClientsModel.fromJson(Map<String, dynamic> json) => ClientsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        clients: json["clients"] == null
            ? []
            : List<Client>.from(
                json["clients"]!.map((x) => Client.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "clients": clients == null
            ? []
            : List<dynamic>.from(clients!.map((x) => x.toJson())),
      };
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phoneNumber,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
      };
}
