
import 'package:Science/Bloc/QuizBloc.dart';
import 'package:Science/Bloc/SubjectBloc.dart';
import 'package:Science/DataStore.dart';
import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Helper/AppTextStyle.dart';
import 'package:Science/Models/QuizModel.dart';
import 'package:Science/Models/SubjectModel.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

class MyQuizzes extends BaseUI<QuizBloc> {
  @override
  _MyQuizzesState createState() => _MyQuizzesState();
  MyQuizzes() : super(bloc: QuizBloc());

}

class _MyQuizzesState extends BaseUIState<MyQuizzes> {
  QuizBloc bloc= QuizBloc();

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
        "اختباراتي",
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
        stream: bloc!.dataControllerMyQuizzes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.code==401)
              {
                print("NOOOOOOOO");
              }
            if (snapshot.data == null || snapshot.data!.quizzes!.isEmpty) {
              return helper.noDataFound(
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
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
          helper.mainTextView(texts: [quizM!.title!],textsStyle: [AppTextStyle.largeBlackBold,
            AppTextStyle.mediumBlackBold,AppTextStyle.smallBlackBold],textAlign: TextAlign.center,myOverflow: TextOverflow.visible),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          helper.mainTextView(texts: [quizM.user_mark.toString()+" / "+quizM.total_mark.toString()+"\n"
              "","وقت الحل : "+quizM.execution_time!],textsStyle: [AppTextStyle.largeBlackBold,
            AppTextStyle.mediumBlackBold,AppTextStyle.smallBlackBold],textAlign: TextAlign.center)
        ],
      ),
    );
  }
  @override
  void retry() {
    super.retry();
    bloc!.dataControllerMyQuizzes.sink.add(null);
    bloc!.getMyQuizRequest();
  }
  @override
  void init() {
    retry();
  }

}
