
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:dio/dio.dart';

LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
  LessonModel({
    this.message,
    this.code,
    this.lessons,
  });
  String? message;
  int? code;
  List<LessonM>? lessons;

  factory LessonModel.fromJson(Map<String, dynamic> json){
    return LessonModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      lessons: json["data"]['lessons'] == null ? null : List<LessonM>.from(json["data"]['lessons'].map((x) => LessonM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "lessons": lessons == null ? null : List<dynamic>.from(lessons!.map((x) => x)),
  };
}


class LessonM {
  LessonM({
    this.id,
    this.title,
    this.description,
    this.course_id,
    this.videos,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?title;
  String ?description;
  int ?course_id;
  List<VideoM>?videos;
  String ?created_at;
  String ?updated_at;


  factory LessonM.fromJson(Map<String, dynamic> json) {
    return LessonM(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      course_id: json["course_id"] == null ? null : json["course_id"],
      videos: json["videos"] == null ? null : List<VideoM>.from(json["videos"].map((x) => VideoM.fromJson(x))),
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "course_id": course_id == null ? null : course_id,
    "videos": videos == null ? null : List<dynamic>.from(videos!.map((x) => x)),
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}

class VideoM {
  VideoM({
    this.id,
    this.title,
    this.link,
    this.lesson_id,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?title;
  String ?link;
  int ?lesson_id;
  String ?created_at;
  String ?updated_at;


  factory VideoM.fromJson(Map<String, dynamic> json) {
    return VideoM(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      link: json["link"] == null ? null : json["link"],
      lesson_id: json["lesson_id"] == null ? null : json["lesson_id"],
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "link": link == null ? null : link,
    "lesson_id": lesson_id == null ? null : lesson_id,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}




