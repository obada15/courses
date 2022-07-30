
import 'dart:convert';

GeneralModel generalModelFromJson(String str) => GeneralModel.fromJson(json.decode(str));

String generalModelToJson(GeneralModel data) => json.encode(data.toJson());

class GeneralModel {
  GeneralModel({
    this.message,
    this.data,
    this.errors,
    this.code,
  });

  String? message;
  dynamic data;
  dynamic errors;
  int? code;

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"],
    errors: json["errors"] == null ? null : json["errors"],
    code: json["status_code"] == null ? -1 : json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data,
    "errors": errors == null ? null : errors,
    "code": code == null ? null : code,
  };
}
