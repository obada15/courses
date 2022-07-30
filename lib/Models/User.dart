
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

  String? message;
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
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["api_token"] == null ? null : json["api_token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
  };
}


class User {
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
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
  dynamic phone;
  String? idImage;
  String? displayImageName;


  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json[" first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    phone: json["mobile_number"] == null ? null : json["mobile_number"],
    email: json["email"] == null ? null : json["email"],
    idImage: json["id_image"] == null ? null : json["id_image"],
  );
/*
  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "user_first_name": userFirstName == null ? null : userFirstName,
    "user_last_name": userLastName == null ? null : userLastName,
    "user_full_name": userFullName == null ? null : userFullName,
    "user_email": userEmail == null ? null : userEmail,
    "user_address": userAddress,
    "user_phone": userPhone,
    "user_role": userRole == null ? null : userRole!.toJson(),
    "user_status": userStatus == null ? null : userStatus,
    "user_valet_company_id": userValetCompanyId == null ? null : userValetCompanyId,
    "user_subscribed_business": userSubscribedBusiness,
    "user_image": userImage == null ? null : userImage,
  };
*/

  Future<FormData> toJson() async {
    FormData _formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "mobile_number": phone,
      "password": password,
      "email": email,
      "id_image": (idImage == null || (idImage ?? "").isEmpty ) ? null : await MultipartFile.fromFile(idImage ?? "", filename: (displayImageName ?? "file"),) ,
    });
    return _formData;
  }
}

