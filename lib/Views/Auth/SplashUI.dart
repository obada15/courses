
import 'package:Courses/Bloc/AuthBloc.dart';
import 'package:Courses/Extensions/StringsEx.dart';
import 'package:Courses/Views/Auth/SignInUI.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/Home/HomeUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../DataStore.dart';
import '../../Widget/HelperWigets.dart';

class SplashUI extends BaseUI<AuthBloc> {
  @override
  _SplashUIState createState() => _SplashUIState();

  SplashUI() : super(bloc: AuthBloc());
}

class _SplashUIState extends BaseUIState<SplashUI> {
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, scaffoldKey,"");
  }

  @override
  Widget buildUI(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: helper.mainBoxDecoration(),
        child: Center(
          child:
          Container(
            // width: MediaQuery.of(context).size.width * 0.6,
            // height: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              "logo.png".assets,
              width: 130,
              height: 130,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void init() {

    // print("splash start ${dataStore?.isFirstTime ?? true} \n token: ${dataStore?.user?.data?.token ?? ""}");
    //
    // genBloc.getSettings(onData: (val){
    //   newRoot();
    //   print("dataStore.settings");
    //   print(dataStore.settings.toJson());
    // },onError: (error){
    //   init();
    // });

      Future.delayed(Duration(seconds: 2), () {
       if(mounted)
        newRoot();
      });

    // TODO: implement init
  }

  void newRoot(){
      if ((dataStore?.user?.data?.api_token?? "").isEmpty){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => SignInIU()
        ),(route){
          return false;
        });

      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => HomeUI()
        ),(route){
          return false;
        });
      }
    }

}
