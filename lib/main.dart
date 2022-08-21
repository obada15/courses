import 'dart:convert';
import 'dart:io';
import 'package:Courses/Bloc/GeneralBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Views/Auth/SplashUI.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter_windowmanager/flutter_windowmanager.dart';

main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await dataStore.getUser();


  if(Platform.isAndroid)
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Courses",
      navigatorKey: genBloc.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashUI(),
    );
  }
}


