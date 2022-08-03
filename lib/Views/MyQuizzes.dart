
import 'package:Courses/Bloc/QuizBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/QuizUI.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyQuizzes extends BaseUI<QuizBloc> {
  @override
  _MyQuizzesState createState() => _MyQuizzesState();
  MyQuizzes() : super(bloc: QuizBloc());

}

class _MyQuizzesState extends BaseUIState<MyQuizzes> {

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
        "My Quizzes",
        nameUI: "My Quizzes"
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
    return StreamBuilder<MyQuizModel?>(
      //favorite api stream
        stream: widget.bloc!.dataControllerMyQuizzes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.code==401)
              {
                print("NOOOOOOOO");
              }
            if (snapshot.data == null || snapshot.data!.quizzes!.isEmpty) {
              return helper.noDataFound(
                  context, "no data found" + "\n" + "pls try again");
            }
            MyQuizModel? data= snapshot.data;

            return Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Expanded(
                  child: categoryListView(data!),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        });
  }

  Widget categoryListView(MyQuizModel quiz) {
    return SingleChildScrollView(
        child: Center(child: Wrap(
          spacing: 20,
          runSpacing: 30,
          direction: Axis.horizontal,
          children: quiz.quizzes!
              .map((x) => GestureDetector(
            child: categoryListViewItem(x),
          ))
              .toList(),
        ),)
    );
  }

  Widget categoryListViewItem(MyQuizM quizM) {
    return Container(
      width: 160,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.silver,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/quiz.png"),
            width: 100,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          helper.mainTextView(texts: [quizM!.title!+"\n",quizM.user_mark.toString()+" / "+quizM.total_mark.toString()+"\n"
              "","Solving Time : "+quizM.execution_time!],textsStyle: [AppTextStyle.largeBlackBold,
            AppTextStyle.mediumBlackBold,AppTextStyle.smallBlackBold],textAlign: TextAlign.center)
        ],
      ),
    );
  }
  @override
  void retry() {
    super.retry();
    widget.bloc!.dataControllerMyQuizzes.sink.add(null);
    widget.bloc!.getMyQuizRequest();
  }
  @override
  void init() {
    retry();
  }

}
