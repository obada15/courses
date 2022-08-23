
import 'package:Science/Models/GeneralRespones.dart';
import 'package:Science/Models/LessonModel.dart';
import 'package:Science/Models/QuizModel.dart';
import 'package:Science/Resources/ApiProvider.dart';
import 'package:Science/Widget/AppDialogs.dart';
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

  PublishSubject<GeneralModel?> dataControllerQuizResult = PublishSubject<GeneralModel?>();
  Stream<GeneralModel?> get dataStreamQuizResult => dataControllerQuizResult.stream;

  PublishSubject<MyQuizModel?> dataControllerMyQuizzes = PublishSubject<MyQuizModel?>();
  Stream<MyQuizModel?> get dataStreamMyQuizzes => dataControllerMyQuizzes.stream;
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
  quizResult(QuizResultModel quizResultModel,{onData,onError}){
    apiProvider.quizResult(quizResultModel).then((value) => {
      dataControllerQuizResult.sink.add(value),
      onData(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  getMyQuizRequest({onData,onError}){
    apiProvider.getMyQuizzes().then((value) => {

      dataControllerMyQuizzes.sink.add(value)
    }, onError:(error){
      print("IIIIIIIIII");
      print(error.toString());
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }


}