
import 'package:Courses/Resources/ApiProvider.dart';
import 'package:Courses/Widget/AppDialogs.dart';
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
/*
  postRequest(eventDateId,email,phone,keyNumber,{onData,onError}){
    apiProvider.createTicket(eventDateId,email,phone,keyNumber).then((value) => {
      createdDataController.sink.add(value),
      onData(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  updateRequestNew(eventDateId,email,phone,keyNumber,model,colorID,{onData,onError}){
    apiProvider.updateTicketNew(eventDateId,email,phone,keyNumber,model,colorID).then((value) => {
     // createdDataController.sink.add(value),
    print("eeeeeeeeeeeeee "),
      if(value.code!=200)
    showErrorDialog(genBloc.navigatorKey.currentContext,value.message),

        onData(value)
    }, onError:(error){

      showErrorDialog(genBloc.navigatorKey.currentContext,error is AppMsg ? error.data.toString() :  error.toString());
      if (onError != null){
        onError(error);
      }
    });
  }
  getRequest(id,{onData,onError}){

    apiProvider.getTickets(id).then((value) => {
      dataController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
  getRequestDetails(id,{onData,onError}){
    apiProvider.getTicketDetails(id).then((value) => {
      dataDetailsController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
*/
}