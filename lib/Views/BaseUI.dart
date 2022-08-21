import 'package:Courses/Bloc/BaseBloc.dart';
import 'package:Courses/Bloc/GeneralBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Resources/AppMsg.dart';
import 'package:Courses/Views/Auth/SplashUI.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

abstract class BaseUI<Bloc extends BaseBloc> extends StatefulWidget {
  final Bloc? bloc;
   bool withRefresh;

  BaseUI({this.bloc,this.withRefresh=true});
}

abstract class BaseUIState<basePage extends BaseUI> extends State<basePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedBottomNavigationBarIndex = 0;
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    return widget.withRefresh? ( refreshIndicatorApp() != null ? refreshIndicatorApp() : buildScaffold(scaffoldKey)):
    buildScaffold(scaffoldKey);
  }

  RefreshIndicator refreshIndicatorApp(){
    return RefreshIndicator(
      child: buildScaffold(scaffoldKey),
      onRefresh: onRefresh,
    );
  }
  Scaffold buildScaffold(GlobalKey<ScaffoldState> _scaffoldKey){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: this.buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      key: scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child:  Stack(
          children: <Widget>[
            //helper.background(context),
            StreamBuilder<AppMsg?>(
                stream: widget.bloc!.uiErrorsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(
                        "error handler herer ${snapshot.data!.data.toString().isEmpty ? "general error": snapshot.data!.data.toString()}");
                    var res = snapshot.data!.data.toString().isEmpty
                        ? "general error"
                        : snapshot.data!.data.toString();
                    // Future.delayed(
                    //     const Duration(milliseconds: 0),
                    //         () => {
                    //       showErrorDialog(context, res),
                    //     });
                    // showErrorDialog(context, snapshot.data.toString());
                    return helper.mainTryAgainWidget(context, retry);
                    // return Container(child: Center(child: Text(snapshot.data.data.toString()),),);
                  }
                  return this.buildUI(context);
                }),
          ],
        ),
      ),
      floatingActionButton: buildActionButton(),
    );
  }

  void onItemBottomNavigationBarTapped(int index) {
    setState(() {
      selectedBottomNavigationBarIndex = index;
    });
    switch (index){
      case 1:{
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      //       builder: (context) => EventsUI()
      //   ),(route){
      //     return false;
      //   });
      // }
      Navigator.pushNamed(context, 'page2');}
      break;
      default:{

      }
      break;

    }
    print("sadasdasda $selectedBottomNavigationBarIndex");

  }
  Widget buildUI(BuildContext context);
  AppBar buildAppBar();
  BottomNavigationBar? buildBottomNavigationBar(){
    return null;
  }
  Widget? buildActionButton(){
    return null;
  }

  @override
  void initState() {
    widget.bloc!.errorsStream.listen((data) {
      print("base bloc errorsStream listen AppMsg error handler ${data}");
      AppMsg error = data;
      if (error.code == 401) {
       // Phoenix.rebirth(context);
         handleNotAuthUser();
      } else if (error.code == -2) {
        print(error.data.toString());
        // Fluttertoast.showToast(msg: error.data.toString());
        widget.bloc!.uiErrorConteroller.sink.add(error);
      } else {
        // Fluttertoast.showToast(msg: error.data.toString());
        widget.bloc!.uiErrorConteroller.sink.add(error);
      }
    }, onError: (error) {
      Fluttertoast.showToast(msg: error.toString());
      widget.bloc!.uiErrorConteroller.sink
          .add(AppMsg(code: -2, data: error.toString()));
    });
    this.init();
    super.initState();
  }

  void init();
  void disposeControllers() {}
  void retry() {
    widget.bloc!.uiErrorConteroller.sink.add(null);
  }

  Future<void> onRefresh() async {
    retry();
  }

  @override
  void dispose() {
    widget.bloc!.dispose();
    super.dispose();
  }

  Widget noInternetConnection() {
    return Container();
  }

  void handleNotAuthUser() {
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
      return true;
    });
  }
}
