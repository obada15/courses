
import 'package:Courses/Bloc/QuizBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/QuizUI.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyProfile extends BaseUI<QuizBloc> {
  @override
  _MyProfileState createState() => _MyProfileState();
  MyProfile() : super(bloc: QuizBloc());

}

class _MyProfileState extends BaseUIState<MyProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "My Profile",
        nameUI: "My Profile"
    );
  }

  @override
  Widget buildUI(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          children: [
            Expanded(child: bodyUI()),
            SizedBox(
              height: 80,
            ),
          ],
        );
      },
    );
  }
  @override
  Widget bodyUI() {
    return Center(child: Text("Soon ..",style: TextStyle(color: AppColors.primary),),);
  }
  @override
  void retry() {
    super.retry();

  }
  @override
  void init() {
    retry();
  }

}
