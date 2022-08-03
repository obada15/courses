
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:dio/dio.dart';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    this.message,
    this.code,
    this.quizzes,
  });
  String? message;
  int? code;
  List< QuizM>? quizzes;

  factory QuizModel.fromJson(Map<String, dynamic> json){
    return QuizModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      quizzes: json["data"]['quizzes'] == null ? null : List<QuizM>.from(json["data"]['quizzes'].map((x) => QuizM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "quizzes": quizzes == null ? null : List<dynamic>.from(quizzes!.map((x) => x)),
  };
}

QuizModel questionModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String questionModelToJson(QuizModel data) => json.encode(data.toJson());
class QuestionModel {
  QuestionModel({
    this.message,
    this.code,
    this.questions,
  });
  String? message;
  int? code;
  List< QuestionM>? questions;

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      questions: json["data"]['questions'] == null ? null : List<QuestionM>.from(json["data"]['questions'].map((x) => QuestionM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "questions": questions == null ? null : List<dynamic>.from(questions!.map((x) => x)),
  };
}


class QuizM {
  QuizM({
    this.id,
    this.title,
    this.description,
    this.mark,
    this.is_completed,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?title;
  String ?description;
  int ?mark;
  int ?is_completed;
  String ?created_at;
  String ?updated_at;


  factory QuizM.fromJson(Map<String, dynamic> json) {
    return QuizM(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      mark: json["mark"] == null ? null : json["mark"],
      is_completed: json["is_completed"] == null ? null : json["is_completed"],
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "mark": mark == null ? null : mark,
    "is_completed": is_completed == null ? null : is_completed,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}
class QuestionM {
  QuestionM({
    this.id,
    this.text,
    this.type,
    this.mark,
    this.image,
    this.quizze_id,
    this.questionSelections,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?text;
  String ?type;
  int ?mark;
  int ?quizze_id;
  String ?image;
  List< QuestionSelectionsM>? questionSelections;

  String ?created_at;
  String ?updated_at;


  factory QuestionM.fromJson(Map<String, dynamic> json) {
    return QuestionM(
      id: json["id"] == null ? null : json["id"],
      text: json["text"] == null ? null : json["text"],
      type: json["type"] == null ? null : json["type"],
      mark: json["mark"] == null ? null : json["mark"],
      image: json["image"] == null ? null : json["image"],
      quizze_id: json["quizze_id"] == null ? null : json["quizze_id"],
      questionSelections: json['qestion_selections'] == null ? null : List<QuestionSelectionsM>.from(json['qestion_selections'].map((x) => QuestionSelectionsM.fromJson(x))),
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
    "type": type == null ? null : type,
    "mark": mark == null ? null : mark,
    "image": image == null ? null : image,
    "quizze_id": quizze_id == null ? null : quizze_id,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };
}
class QuestionSelectionsM {
  QuestionSelectionsM({
    this.id,
    this.text,
    this.is_true,
    this.question_id,
    this.created_at,
    this.updated_at,
  });

  int ?id;
  String ?text;
  int ?is_true;
  int ?question_id;
  String ?created_at;
  String ?updated_at;


  factory QuestionSelectionsM.fromJson(Map<String, dynamic> json) {
    return QuestionSelectionsM(
      id: json["id"] == null ? null : json["id"],
      text: json["text"] == null ? null : json["text"],
      is_true: json["is_true"] == null ? null : json["is_true"],
      question_id: json["question_id"] == null ? null : json["question_id"],
      created_at: json["created_at"] == null ? null : json["created_at"],
      updated_at: json["updated_at"] == null ? null : json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
    "is_true": is_true == null ? null : is_true,
    "question_id": question_id == null ? null : question_id,
    "created_at": created_at == null ? null : created_at,
    "updated_at": updated_at == null ? null : updated_at,
  };

}
class OptionSelection {
  bool isSelected;
  String optionText;
  OptionSelection(this.optionText, this.isSelected);
}
class QuestionAnswer {
  int quizID;
  int questionID;
  int isTrue;
  String textOption;
  String textAnswer;
  QuestionAnswer(this.quizID,this.questionID, this.textOption,this.textAnswer,this.isTrue);
}
class AnswerModel {
  int question_id;
  String answer;
  Map<String, dynamic> toJson() => {
    "question_id": question_id,
    "answer":  answer,
  };

  AnswerModel(this.question_id,this.answer);
}
class QuizResultModel {
  QuizResultModel({
    this.mark,
    this.execution_time,
    this.quize_id,
    this.answers_arr,
  });
  double? mark;
  String? execution_time;
  int? quize_id;
  List< AnswerModel>? answers_arr;

  Map<String, dynamic> toJson() => {
    "mark": mark == null ? null : mark!,
    "execution_time": execution_time == null ? null : execution_time!,
    "quize_id": quize_id == null ? null : quize_id!,
    "answers_arr": answers_arr == null ? null : List<dynamic>.from(answers_arr!.map((x) => x.toJson())),
  };
}

class MyQuizModel {
  MyQuizModel({
    this.message,
    this.code,
    this.quizzes,
  });
  String? message;
  int? code;
  List< MyQuizM>? quizzes;

  factory MyQuizModel.fromJson(Map<String, dynamic> json){
    return MyQuizModel(
      message: json["message"] == null ? null : json["message"]!,
      code: json["status_code"] == null ? null : json["status_code"]!,
      quizzes: json["data"]['my_quizzess'] == null ? null : List<MyQuizM>.from(json["data"]['my_quizzess'].map((x) => MyQuizM.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message!,
    "status_code": code == null ? null : code!,
    "my_quizzess": quizzes == null ? null : List<dynamic>.from(quizzes!.map((x) => x)),
  };
}
class MyQuizM {
  MyQuizM({
    this.title,
    this.total_mark,
    this.user_mark,
    this.execution_time,
  });

  String ?title;
  double ?total_mark;
  double ?user_mark;
  String ?execution_time;


  factory MyQuizM.fromJson(Map<String, dynamic> json) {

    return MyQuizM(
      title: json["title"] == null ? null : json["title"],
      total_mark: json["total_mark"] == null ? null : double.parse(json["total_mark"].toString()),
      user_mark: json["user_mark"] == null ? null :double.parse( json["user_mark"].toString()),
      execution_time: json["execution_time"] == null ? null : json["execution_time"],
    );
  }
}



