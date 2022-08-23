

import 'dart:io';

import 'package:Science/Bloc/BaseBloc.dart';
import 'package:Science/Models/User.dart';
import 'package:rxdart/rxdart.dart';

import '../DataStore.dart';
import '../Resources/ApiProvider.dart';
import '../Resources/AppMsg.dart';
import '../Widget/AppDialogs.dart';
import 'GeneralBloc.dart';

class AuthBloc extends BaseBloc{

  PublishSubject<User> dataController = PublishSubject<User>();
  Stream<User> get dataStream => dataController.stream;
/*
  getRequest({onData,onError}){
    apiProvider.getProfile().then((value) => {
      dataController.sink.add(value)
    }, onError:(error){
      handleError(error);
      if (onError != null){
        onError(error);
      }
    });
  }
*/
  signUp(
  {User? user,onData,onError}) {
    apiProvider.signUp(user!).then((value) {
      onData(value);

      /*dataStore.setUser(value).then((_) {
        // genBloc.updateToken(notificationHelper.token);
      });*/
    }, onError:(error){
      print("(Un-handler x) signUp AppMsg error handler herer ${error.toString()} ");

      //showErrorDialog(genBloc.navigatorKey.currentContext,error is AppMsg ? error.data.toString() :  error.toString());
      if (onError != null){
        onError(error);
      }
      // handleError(error);
    });

  }

  login({required String email , required String password ,onData,onError}) {

    apiProvider.login(email, password).then((value) {

      dataStore.setUser(value).then((_) {
        onData(value);
        // genBloc.updateToken(notificationHelper.token);
      });
    }, onError:(error){
      //showErrorDialog(genBloc.navigatorKey.currentContext,error is AppMsg ? error.data.toString() :  error.toString());
      if (onError != null){
        onError(error);
      }

    });
  }


}