
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:dio/dio.dart';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  SubjectModel({
    this.message,
    this.code,
    this.subjects,
    this.courses,
    this.freeCourses,
  });
  String? message;
  int? code;
  List<SubjectM>? subjects;
  List<CourseM>? courses;
  List<CourseM>? freeCourses;

  factory SubjectModel.fromJson(Map<String, dynamic> json){
    return SubjectModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      subjects: json["data"]['subjects'] == null ? null : List<SubjectM>.from(json["data"]['subjects'].map((x) => SubjectM.fromJson(x))),
      courses: json["data"]['courses'] == null ? null : List<CourseM>.from(json["data"]['courses'].map((x) => CourseM.fromJson(x))),
      freeCourses: json["data"]['free_courses'] == null ? null : List<CourseM>.from(json["data"]['free_courses'].map((x) => CourseM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "subjects": subjects == null ? null : List<dynamic>.from(subjects!.map((x) => x)),
    "courses": courses == null ? null : List<dynamic>.from(courses!.map((x) => x)),
    "free_courses": freeCourses == null ? null : List<dynamic>.from(freeCourses!.map((x) => x)),
  };
}

class CourseModel {
  CourseModel({
    this.message,
    this.code,
    this.courses,
  });
  String? message;
  int? code;
  List<CourseM>? courses;

  factory CourseModel.fromJson(Map<String, dynamic> json){
    return CourseModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      courses: json["data"]['courses'] == null ? null : List<CourseM>.from(json["data"]['courses'].map((x) => CourseM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "courses": courses == null ? null : List<dynamic>.from(courses!.map((x) => x)),
  };
}

class SubjectM {
  SubjectM({
    this.id,
    this.title,
    this.image,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?title;
  String ?image;
  String ?created_at;
  String ?updated_at;


  factory SubjectM.fromJson(Map<String, dynamic> json) {
    return SubjectM(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      image: json["image"] == null ? null : json["image"],
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}


class CourseM {
  CourseM({
    this.id,
    this.title,
    this.image,
    this.description,
    this.subject_id,
    this.is_free,
    this.views,
    this.price,
    this.is_mine,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?title;
  String ?image;
  String ?description;
  int ?subject_id;
  int ?is_free;
  int ?views;
  int ?price;
  int ?is_mine;
  String ?created_at;
  String ?updated_at;


  factory CourseM.fromJson(Map<String, dynamic> json) {
    return CourseM(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      image: json["image"] == null ? null : json["image"],
      description: json["description"] == null ? null : json["description"],
      subject_id: json["subject_id"] == null ? null : json["subject_id"],
      is_free: json["is_free"] == null ? null : json["is_free"],
      views: json["views"] == null ? null : json["views"],
      price: json["price"] == null ? null : json["price"],
      is_mine: json["is_mine"] == null ? null : json["is_mine"],
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
    "subject_id": subject_id == null ? null : subject_id,
    "is_free": is_free == null ? null : is_free,
    "views": views == null ? null : views,
    "price": price == null ? null : price,
    "is_mine": is_mine == null ? null : is_mine,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}


