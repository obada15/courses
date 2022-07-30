
import 'package:Courses/Models/LessonModel.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Resources/ApiProvider.dart';
import 'package:Courses/Widget/AppDialogs.dart';
import 'package:rxdart/rxdart.dart';

import '../Models/SubjectModel.dart';
import '../Resources/AppMsg.dart';
import 'BaseBloc.dart';
import 'GeneralBloc.dart';

class QuizBloc extends BaseBloc{

  PublishSubject<QuizModel?> dataController = PublishSubject<QuizModel?>();
  Stream<QuizModel?> get dataStream => dataController.stream;

  PublishSubject<QuestionModel?> dataControllerQuestions = PublishSubject<QuestionModel?>();
  Stream<QuestionModel?> get dataStreamQuestions => dataControllerQuestions.stream;
  getRequest({onData,onError}){
    apiProvider.getQuizzes().then((value) => {
      dataController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  getQuestionsRequest(String id,{onData,onError}){
    apiProvider.getQuestions(id).then((value) => {
      dataControllerQuestions.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }


}