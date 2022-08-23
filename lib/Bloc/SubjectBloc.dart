
import 'package:Science/Resources/ApiProvider.dart';
import 'package:Science/Widget/AppDialogs.dart';
import 'package:rxdart/rxdart.dart';

import '../Models/SubjectModel.dart';
import '../Resources/AppMsg.dart';
import 'BaseBloc.dart';
import 'GeneralBloc.dart';

class SubjectBloc extends BaseBloc{


  PublishSubject<SubjectModel?> dataController = PublishSubject<SubjectModel?>();
  Stream<SubjectModel?> get dataStream => dataController.stream;

  PublishSubject<CourseModel?> dataCoursesController = PublishSubject<CourseModel?>();
  Stream<CourseModel?> get dataCoursesStream => dataCoursesController.stream;

  PublishSubject<CourseModel?> dataMyCoursesController = PublishSubject<CourseModel?>();
  Stream<CourseModel?> get dataMyCoursesStream => dataMyCoursesController.stream;
  getRequest({onData,onError}){

    apiProvider.getSubjects().then((value) => {
      dataController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  getCoursesRequest(String id,{onData,onError}){

    apiProvider.getCoursesByID(id).then((value) => {
      dataCoursesController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }

  getMyCoursesRequest({onData,onError}){
    apiProvider.getMyCourses().then((value) => {
      dataMyCoursesController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  InsertCode({required String code ,onData,onError}) {

    apiProvider.InsertCode(code).then((value) {
      onData(value);
    }, onError:(error){
      if (onError != null){
        onError(error);
      }
    });
  }

}