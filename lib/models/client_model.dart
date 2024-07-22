// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  int? statusCode;
  String? message;
  Client? client;

  ClientModel({
    this.statusCode,
    this.message,
    this.client,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        statusCode: json["statusCode"],
        message: json["message"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "client": client?.toJson(),
      };
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? type;
  String? category;
  String? email;
  String? username;
  String? phoneNumber;
  String? password;
  String? companyName;
  String? notes;
  String? fax;
  String? website;
  String? address;
  String? postalCode;
  String? villa;
  String? deliveryAddress;
  String? deliveryPostalCode;
  String? deliveryVilla;
  String? reliability;
  num? discount;
  String? delayDelivery;
  num? freeShippingAmount;
  num? shippingCosts;
  String? hours;
  String? tva;
  String? siren;
  String? codeNaf;
  String? res;
  String? sarlSas;
  String? contact;
  String? iban;
  String? bic;
  String? bank;
  String? createdAt;
  String? deletedAt;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.type,
    this.category,
    this.email,
    this.username,
    this.phoneNumber,
    this.password,
    this.companyName,
    this.notes,
    this.fax,
    this.website,
    this.address,
    this.postalCode,
    this.villa,
    this.deliveryAddress,
    this.deliveryPostalCode,
    this.deliveryVilla,
    this.reliability,
    this.discount,
    this.delayDelivery,
    this.freeShippingAmount,
    this.shippingCosts,
    this.hours,
    this.tva,
    this.siren,
    this.codeNaf,
    this.res,
    this.sarlSas,
    this.contact,
    this.iban,
    this.bic,
    this.bank,
    this.createdAt,
    this.deletedAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        type: json["type"],
        category: json["category"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        companyName: json["company_name"],
        notes: json["notes"],
        fax: json["fax"],
        website: json["website"],
        address: json["address"],
        postalCode: json["postal_code"],
        villa: json["villa"],
        deliveryAddress: json["delivery_address"],
        deliveryPostalCode: json["delivery_postal_code"],
        deliveryVilla: json["delivery_villa"],
        reliability: json["reliability"],
        discount: json["discount"],
        delayDelivery: json["delay_delivery"],
        freeShippingAmount: json["free_shipping_amount"],
        shippingCosts: json["shipping_costs"],
        hours: json["hours"],
        tva: json["tva"],
        siren: json["siren"],
        codeNaf: json["code_naf"],
        res: json["res"],
        sarlSas: json["sarl_sas"],
        contact: json["contact"],
        iban: json["iban"],
        bic: json["bic"],
        bank: json["bank"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "type": type,
        "category": category,
        "email": email,
        "username": username,
        "phone_number": phoneNumber,
        "password": password,
        "company_name": companyName,
        "notes": notes,
        "fax": fax,
        "website": website,
        "address": address,
        "postal_code": postalCode,
        "villa": villa,
        "delivery_address": deliveryAddress,
        "delivery_postal_code": deliveryPostalCode,
        "delivery_villa": deliveryVilla,
        "reliability": reliability,
        "discount": discount,
        "delay_delivery": delayDelivery,
        "free_shipping_amount": freeShippingAmount,
        "shipping_costs": shippingCosts,
        "hours": hours,
        "tva": tva,
        "siren": siren,
        "code_naf": codeNaf,
        "res": res,
        "sarl_sas": sarlSas,
        "contact": contact,
        "iban": iban,
        "bic": bic,
        "bank": bank,
        "created_at": createdAt,
        "deleted_at": deletedAt,
      };
}
