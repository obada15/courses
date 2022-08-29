
import 'dart:convert';

import 'package:dio/dio.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.code,
    this.data,
  });

  dynamic message;
  int? code;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) =>UserModel(
    message: json["message"] == null ? null : json["message"],
    code: json["status_code"] == null ? null : json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "code": code == null ? null : code,
    "data": data == null ? null : data!.toJson(),
  };

}

class Data {
  Data({
    this.api_token,
    this.user,
  });

  String? api_token;
  UserM ?user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    api_token: json["api_token"] == null ? null : json["api_token"],
    user: json['user'] == null ? null : UserM.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    "api_token": api_token == null ? null : api_token,
    "user": user == null ? null : user!.toJson(),
  };
}
class UserM{
  UserM({
    this.id,
    this.first_name,
    this.last_name,
    this.mobile_number,
  });

  String? first_name;
  String? last_name;
  String? mobile_number;
  int? id;

  factory UserM.fromJson(Map<String, dynamic> json) => UserM(
    id: json["id"] == null ? null : json["id"],
    first_name: json["first_name"] == null ? null : json["first_name"],
    last_name: json["last_name"] == null ? null : json["last_name"],
    mobile_number: json["mobile_number"] == null ? null : json["mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": first_name == null ? null : first_name,
    "last_name": last_name == null ? null : last_name,
    "mobile_number": mobile_number == null ? null : mobile_number,
  };
}


class User {
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.idImage,
    this.password,
    this.displayImageName
  });

  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? idImage;
  String? displayImageName;


  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json[" first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    phone: json["mobile_number"] == null ? null : json["mobile_number"],
    idImage: json["id_image"] == null ? null : json["id_image"],
  );

  Future<FormData> toJson() async {
    FormData _formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "mobile_number": phone,
      "password": password,
      "id_image": (idImage == null || (idImage ?? "").isEmpty ) ? null : await MultipartFile.fromFile(idImage ?? "", filename: (displayImageName ?? "file"),) ,
    });
    return _formData;
  }
}

