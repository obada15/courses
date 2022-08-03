
import 'dart:io';

import 'package:Courses/Bloc/HomeBloc.dart';
import 'package:Courses/Extensions/StringsEx.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/MyCourses.dart';
import 'package:Courses/Views/MyProfile.dart';
import 'package:Courses/Views/MyQuizzes.dart';
import 'package:Courses/Views/Quizes.dart';
import 'package:Courses/Views/SubHomeUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeUI extends BaseUI<HomeBloc> {
  @override
  HomeUIState createState() => HomeUIState();

  HomeUI() : super(bloc: HomeBloc());
}

class HomeUIState extends BaseUIState<HomeUI> {

  var eventId = -1;
  var eventIdParent = 0;
  late PersistentTabController controller;
  int indexGlobal=0;
  bool enter=false;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        PersistentTabView(
          context,
          decoration: NavBarDecoration(borderRadius: BorderRadius.circular(10)),
          controller: controller,
          screens: _buildScreens(),
          // itemCount:5,
          bottomScreenMargin: 0,
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style8,
          navBarHeight: 80,
          padding: NavBarPadding.only(bottom: 10),
          /*onItemSelected: (index) async{
            setState(() {
              controller.index = index; // THIS IS CRITICAL!! Don't miss it!
            });
          },*/
          confineInSafeArea: false,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: false, // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 50),
          ),
          // navBarStyle: NavBarStyle.simple,navBarHeight: 60,// Choose the nav bar style with this property.
        ),
      ],
    );
  }

  List<Widget> _buildScreens() {
    List<Widget> temp = [
      SubHomeUI(),
      MyQuizzes(),
      MyCourses(subjectID: "1"),
      Quizes(),
    ];

    return temp;
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    var temp =
    [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home,color: AppColors.primary,),
        inactiveIcon:Icon(Icons.home,color: AppColors.black,),
        textStyle: AppTextStyle.smallBlack,
        title: 'Home',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.darkBackgroundGray,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/ideas.png",color: AppColors.primary,),
        inactiveIcon:Image.asset("assets/ideas.png",color: AppColors.black,),
        textStyle: AppTextStyle.smallBlack,
        title: 'My Quizzes',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.darkBackgroundGray,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/ebook.png",color: AppColors.primary,),
        inactiveIcon:Image.asset("assets/ebook.png",color: AppColors.black,),
        textStyle: AppTextStyle.smallBlack,
        title: 'My Courses',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.darkBackgroundGray,
      ),

      PersistentBottomNavBarItem(
        icon: Image.asset("assets/quizicon.png",color: AppColors.primary,),
        inactiveIcon:Image.asset("assets/quizicon.png",color: AppColors.black,),
        textStyle: AppTextStyle.smallBlack,
        title: 'Quizzes',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.darkBackgroundGray,
      ),

    ];

    return temp;
  }
  @override
  AppBar buildAppBar() {
    // TODO: implement buildAppBar
    throw UnimplementedError();
  }

  @override
  Widget buildUI(BuildContext context) {
    // TODO: implement buildUI
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    controller = PersistentTabController(initialIndex: 0);

  }


}