
import 'package:Science/Bloc/QuizBloc.dart';
import 'package:Science/Bloc/SubjectBloc.dart';
import 'package:Science/DataStore.dart';
import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Helper/AppTextStyle.dart';
import 'package:Science/Models/QuizModel.dart';
import 'package:Science/Models/SubjectModel.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Views/Quiz/QuizUI.dart';
import 'package:Science/Widget/AppDialogs.dart';
import 'package:Science/Widget/CourseTile.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
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
        "الاختبارات",
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
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
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
            if(x.type!.compareTo("training")==0)
              {
                var back=await pushNewScreen(context, screen: QuizUI(
                  quizID: x.id.toString(),
                  quizMark: double.parse(x.mark.toString()),
                  type:x.type! ,
                ),
                  withNavBar:false,
                );
                if(back!=null)
                {
                  retry();
                }
              }
            else{
              if(x.is_completed==1)
              {
                showAlertDialog(context,"هذا الاختبار لقد قمت به بالفعل",isError: false);
              }
              else{
                var back=await pushNewScreen(context, screen: QuizUI(
                  quizID: x.id.toString(),
                  quizMark: double.parse(x.mark.toString()),
                  type:x.type! ,
                ),
                  withNavBar:false,
                );
                if(back!=null)
                {
                  retry();
                }
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
