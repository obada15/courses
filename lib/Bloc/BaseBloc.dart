import 'package:Courses/DataStore.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../Resources/AppMsg.dart';
import 'GeneralBloc.dart';

abstract class BaseBloc{

  PublishSubject _generalErrorsController = PublishSubject();

  Stream get errorsStream => _generalErrorsController.stream;

  PublishSubject<AppMsg?> uiErrorConteroller = PublishSubject<AppMsg?>();

  Stream<AppMsg?> get uiErrorsStream => uiErrorConteroller.stream;



  fetchData<T>(Future<dynamic> func, void onData(T data) , void onError(dynamic error)){
    print("fetchData xx start AppMsg error handler herer");
    func.then((val){
      print("fetchData xx start func.then AppMsg error handler herer ${val}");

      if (val == null) {
        return;
      }
      print("error handler herer val$val ");
      if( ( val!= null && val.code != null) && (val.code == 200 || val.code == 201 || val.code == 202 || val.code == 203 || val.code == 204))
      onData(val);
      else {
        print("(handler 2) fetchData  AppMsg error handler herer error${val.toString()} ");

        onError(val);
      }
    }) .catchError((error){
      print("fetchData xx start catchError AppMsg error handler herer");

      print("(handler) fetchData AppMsg error handler herer error ggg ${error.toString()} ");
      if(error is AppMsg)
      {
       if(error.code == -1 || error.code == -2 || error.code == 401)
         {
          _generalErrorsController.sink.add(error);
          dataStore.setUser(null).then((val) {
            Fluttertoast.showToast(
                msg: 'There is another login operation from another device, please login again',
                toastLength: Toast.LENGTH_LONG);
            Phoenix.rebirth(genBloc.navigatorKey.currentContext!);
          });
         }
       else {
         print("(Un-handler) fetchData else AppMsg error handler herer error${error.toString()} ");
         onError(error);
       }
      }
      else {
        print("(Un-handler) fetchData else else AppMsg error handler herer error${error.toString()} ");
      }
    });
  }
  void handleError(error){
    if(error is AppMsg)
    {
      if(
      // error.code == -1 || error.code == -2 ||
          error.code == 401)
      {
        handleNotAuthUser();
      }
      else {
        _generalErrorsController.sink.add(error);
        print("(Un-handler) fetchData else AppMsg error handler herer error${error.toString()} ");
        // onError(error);
      }
    }
    else {
      _generalErrorsController.sink.add(AppMsg(code: -2,data: error));
      print("(Un-handler) fetchData else else AppMsg error handler herer error${error.toString()} ");
    }
  }
  void handleNotAuthUser(){
    dataStore.setUser(null).then((val) {
      Fluttertoast.showToast(
          msg: 'There is another login operation from another device, please login again',
          toastLength: Toast.LENGTH_LONG);
      Phoenix.rebirth(genBloc.navigatorKey.currentContext!);
    });
  }


  dispose(){
    _generalErrorsController.close();
  }

}