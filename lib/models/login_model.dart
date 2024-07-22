// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? statusCode;
  String? message;
  User? user;

  LoginModel({
    this.statusCode,
    this.message,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        statusCode: json["statusCode"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? phoneNumber;
  String? email;
  String? password;
  String? role;
  String? createdAt;
  dynamic deletedAt;
  String? token;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.phoneNumber,
    this.email,
    this.password,
    this.role,
    this.createdAt,
    this.deletedAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "phone_number": phoneNumber,
        "email": email,
        "password": password,
        "role": role,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "token": token,
      };
}
