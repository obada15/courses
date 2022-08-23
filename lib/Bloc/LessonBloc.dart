
import 'package:Science/Models/LessonModel.dart';
import 'package:Science/Resources/ApiProvider.dart';
import 'package:Science/Widget/AppDialogs.dart';
import 'package:rxdart/rxdart.dart';

import '../Models/SubjectModel.dart';
import '../Resources/AppMsg.dart';
import 'BaseBloc.dart';
import 'GeneralBloc.dart';

class LessonBloc extends BaseBloc{

  PublishSubject<LessonModel?> dataController = PublishSubject<LessonModel?>();
  Stream<LessonModel?> get dataStream => dataController.stream;

  getRequest(String id,{onData,onError}){
    apiProvider.getLessonsByID(id).then((value) => {
      dataController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }

}