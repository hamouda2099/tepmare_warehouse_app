// To parse this JSON data, do
//
//     final locationsModel = locationsModelFromJson(jsonString);

import 'dart:convert';

LocationsModel locationsModelFromJson(String str) =>
    LocationsModel.fromJson(json.decode(str));

String locationsModelToJson(LocationsModel data) => json.encode(data.toJson());

class LocationsModel {
  int? statusCode;
  String? message;
  List<Location>? locations;

  LocationsModel({
    this.statusCode,
    this.message,
    this.locations,
  });

  factory LocationsModel.fromJson(Map<String, dynamic> json) => LocationsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Location {
  int? id;
  int? siteId;
  String? site;
  String? hall;
  String? type;
  String? aisle;
  String? field;
  String? position;
  String? level;
  String? barcode;
  String? createdAt;
  String? deletedAt;

  Location({
    this.id,
    this.siteId,
    this.site,
    this.hall,
    this.type,
    this.aisle,
    this.field,
    this.position,
    this.level,
    this.barcode,
    this.createdAt,
    this.deletedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        siteId: json["site_id"],
        site: json["site"],
        hall: json["hall"],
        type: json["type"],
        aisle: json["aisle"],
        field: json["field"],
        position: json["position"],
        level: json["level"],
        barcode: json["barcode"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_id": siteId,
        "site": site,
        "hall": hall,
        "type": type,
        "aisle": aisle,
        "field": field,
        "position": position,
        "level": level,
        "barcode": barcode,
        "created_at": createdAt,
        "deleted_at": deletedAt,
      };
}
