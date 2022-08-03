
import 'package:Courses/Bloc/QuizBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/QuizUI.dart';
import 'package:Courses/Widget/AppDialogs.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Quizes extends BaseUI<QuizBloc> {
  @override
  _QuizesState createState() => _QuizesState();
  Quizes() : super(bloc: QuizBloc());

}

class _QuizesState extends BaseUIState<Quizes> {

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
        "Quizes",
        nameUI: "Quizes"
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
    return StreamBuilder<QuizModel?>(
      //favorite api stream
        stream: widget.bloc!.dataController,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.quizzes!.isEmpty) {
              return helper.noDataFound(
                  context, "no data found" + "\n" + "pls try again");
            }
            QuizModel? data= snapshot.data;

            return Column(
              children: [
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
  Widget categoryListView(QuizModel quiz) {
    return SingleChildScrollView(
      child: Center(child: Wrap(
        spacing: 20,
        runSpacing: 30,
        direction: Axis.horizontal,
        children: quiz.quizzes!
            .map((x) => GestureDetector(
          child: categoryListViewItem(x),
          onTap: () async {
            print(x.id);
            if(x.is_completed==1)
              {
                showAlertDialog(context,"This Quiz is Complete For You",isError: false);
              }else{
             var back=await pushNewScreen(context, screen: QuizUI(
                quizID: x.id.toString(),
                quizMark: double.parse(x.mark.toString()),
              ),
                withNavBar:false,
              );
             if(back!=null)
               {
                 retry();
               }
            }

          },
        ))
            .toList(),
      ),)
    );
  }

  Widget categoryListViewItem(QuizM quizM) {
    return Container(
      width: 160,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/quiz.png"),
            width: 130,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          helper.mainTextView(texts: [quizM!.title!],textsStyle: [AppTextStyle.mediumBlackBold])
        ],
      ),
    );
  }
  @override
  void retry() {
    super.retry();
    widget.bloc!.dataController.sink.add(null);
    widget.bloc!.getRequest();
  }
  @override
  void init() {
    retry();
  }

}
