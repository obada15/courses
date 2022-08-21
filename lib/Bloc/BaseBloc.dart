import 'package:Courses/DataStore.dart';
import 'package:Courses/Views/Auth/SplashUI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../Resources/AppMsg.dart';
import 'GeneralBloc.dart';

abstract class BaseBloc{

  PublishSubject _generalErrorsController = PublishSubject();

  Stream get errorsStream => _generalErrorsController.stream;

  PublishSubject<AppMsg?> uiErrorConteroller = PublishSubject<AppMsg?>();

  Stream<AppMsg?> get uiErrorsStream => uiErrorConteroller.stream;



  void handleError(error){
    if(error is AppMsg)
    {
      if(error.code == 401)
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
          msg: 'هناك عملية تسجيل دخول أخرى من جهاز آخر ، يرجى تسجيل الدخول مرة أخرى',
          toastLength: Toast.LENGTH_LONG);
      Navigator.of(genBloc.navigatorKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => SplashUI()
      ),(route){
        return false;
      });
      //Phoenix.rebirth(genBloc.navigatorKey.currentContext!);
    });
  }


  dispose(){
    _generalErrorsController.close();
  }

}