import 'dart:io';

import 'package:Courses/DataStore.dart';
import 'package:Courses/Views/HomeUI.dart';
import 'package:Courses/Views/SplashUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Views/SubHomeUI.dart';

main () async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
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
      debugShowCheckedModeBanner: false,
      home: SplashUI(),
    );
  }
}


