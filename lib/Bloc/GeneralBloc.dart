
import 'package:flutter/material.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  factory SingletonBloc() {
    return _singletonBloc;
  }


  GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  SingletonBloc._internal();
}

final genBloc = SingletonBloc();