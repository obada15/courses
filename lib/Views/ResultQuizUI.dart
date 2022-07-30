import 'package:Courses/Bloc/QuizBloc.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Helper/ThemeConstant.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/CustomAppButton.dart';
import 'package:Courses/Widget/DiscoButton.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

class ResultQuizUI extends BaseUI<QuizBloc>  {
  final double totalMark;
  final double quizMark;
  final QuestionModel? data;
  ResultQuizUI(this.totalMark, this.quizMark,this.data) : super(bloc: QuizBloc());

  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState  extends BaseUIState<ResultQuizUI> {

  @override
  void initState() {
    super.initState();
  }

  Widget quizResultInfo() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text(
          widget.totalMark.toString() +" from "+widget.quizMark.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "Quiz Result",
        nameUI: "Quiz Result"
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
    return Container(
      alignment: Alignment.center,
     color: AppColors.background,
     padding: EdgeInsets.fromLTRB(10, 10, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        //  Expanded(child: quizResultInfo(),flex: 1,),
          Expanded(child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 10),
              decoration: ThemeConstant.roundBoxDeco(),
              child: SingleChildScrollView(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: widget.data!.questions!
                      .map((x){
                       int index=0;
                        for(int i=0;i<x.questionSelections!.length;i++)
                          {
                            if(x.questionSelections![i].is_true==1)
                              {
                                index=i;
                              }
                          }
                        return ListTile(
                          title: helper.mainTextView(texts: [x.text!],textsStyle: [AppTextStyle.largeBlackBold],textAlign: TextAlign.end),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              helper.mainTextView(texts: [x.questionSelections!.length!=0?x.questionSelections![index].text!:""],textsStyle: [AppTextStyle.normalGray]),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                               x.type!.compareTo("selection")!=0?
                              Center(child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: CustomAppButton(
                                  child: helper.mainTextView(texts: ["Yes, I answered like this"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
                                  padding: EdgeInsets.symmetric(vertical: 13),
                                  borderRadius: 6,
                                  color: AppColors.primary,
                                  onTap: () {

                                  },
                                  elevation: 1,
                                ),
                              ),):Container(),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                              Container(width: MediaQuery.of(context).size.width-50,height: 2,color: AppColors.background,),

                            ],
                          ),
                        );
                  })
                      .toList(),
                ),
              )
          ),flex: 7,),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Expanded(child: Center(child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: CustomAppButton(
              child: helper.mainTextView(texts: ["Submit"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
              padding: EdgeInsets.symmetric(vertical: 13),
              borderRadius: 6,
              color: AppColors.primary,
              onTap: () {

              },
              elevation: 1,
            ),
          ),))
        ],
      ),
    );
  }
  @override
  void init() {

  }
}
