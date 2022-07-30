
import 'package:flutter/material.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  factory SingletonBloc() {
    return _singletonBloc;
  }


  GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  /*f_getNetworks(){
    apiProvider.getNetworks().then((value) {
      _networksController.sink.add(value);
    },onError: (error){

    });
  }*/


  SingletonBloc._internal();

}

final genBloc = SingletonBloc();