// To parse this JSON data, do
//
//     final sitesModel = sitesModelFromJson(jsonString);

import 'dart:convert';

SitesModel sitesModelFromJson(String str) =>
    SitesModel.fromJson(json.decode(str));

String sitesModelToJson(SitesModel data) => json.encode(data.toJson());

class SitesModel {
  int? statusCode;
  String? message;
  List<Site>? sites;

  SitesModel({
    this.statusCode,
    this.message,
    this.sites,
  });

  factory SitesModel.fromJson(Map<String, dynamic> json) => SitesModel(
        statusCode: json["statusCode"],
        message: json["message"],
        sites: json["sites"] == null
            ? []
            : List<Site>.from(json["sites"]!.map((x) => Site.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "sites": sites == null
            ? []
            : List<dynamic>.from(sites!.map((x) => x.toJson())),
      };
}

class Site {
  int? id;
  String? label;
  String? createdAt;
  dynamic deletedAt;

  Site({
    this.id,
    this.label,
    this.createdAt,
    this.deletedAt,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        id: json["id"],
        label: json["label"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "created_at": createdAt,
        "deleted_at": deletedAt,
      };
}
