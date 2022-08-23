import 'package:Science/Bloc/QuizBloc.dart';
import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Helper/AppTextStyle.dart';
import 'package:Science/Helper/ThemeConstant.dart';
import 'package:Science/Models/QuizModel.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Views/Home/HomeUI.dart';
import 'package:Science/Widget/AppDialogs.dart';
import 'package:Science/Widget/CustomAppButton.dart';
import 'package:Science/Widget/DiscoButton.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResultQuizUI extends BaseUI<QuizBloc>  {
  final double totalMark;
  final double quizMark;
  final QuestionModel? data;
  final String? executionQuizTime;
  final String? type;
  final int?quizID;
  final List<QuestionAnswer>answers;
  ResultQuizUI(this.quizID,this.totalMark, this.quizMark,this.data,this.executionQuizTime,this.answers,this.type) : super(bloc: QuizBloc());

  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState  extends BaseUIState<ResultQuizUI> {
  List<AnswerModel>answersList=[];
  late QuizResultModel quizResultModel;
  bool  _isLoading = false;
  late double totalMark;
  bool finish=false;

  @override
  void initState() {
  totalMark=widget.totalMark;
    for(int i=0;i<widget.answers.length;i++)
      {
        answersList.add(AnswerModel(widget.answers[i].questionID, widget.answers[i].textAnswer));
      }
  for(int i=0;i<widget.answers.length;i++)
    {
      print("FFFFFFFFF "+widget.answers[i].textAnswer);
    }


    super.initState();
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
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Column(
            children: [
              Expanded(child: bodyUI()),
            ],
          );
        },
      ),
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
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "الوقت الكلي للحل : "+widget.executionQuizTime.toString(),
                style: TextStyle(fontSize: 25.0,color: AppColors.primary,fontWeight: FontWeight.bold),
              ),
            ],),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "العلامة كاملة : "+totalMark.toString(),
                style: TextStyle(fontSize: 25.0,color: AppColors.primary,fontWeight: FontWeight.bold),
              ),
            ],),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Padding(padding: EdgeInsets.all(5),child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ":الاجابات الصحيحة",
              style: TextStyle(fontSize: 20.0,color: AppColors.black,fontWeight: FontWeight.bold),
            ),
          ],),),
          
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
                       int indexAnswer=0;
                       bool isExist=false;
                        for(int i=0;i<x.questionSelections!.length;i++)
                          {
                            if(x.questionSelections![i].is_true==1)
                              {
                                index=i;
                              }
                          }
                       for(int i=0;i<widget.data!.questions!.length;i++)
                       {
                         if(widget.data!.questions![i].type!.compareTo("written")==0&&x.id==widget.data!.questions![i].id)
                         {
                           indexAnswer=i;
                         }
                       }

                        return ListTile(
                          title:Text(x.text!,style: AppTextStyle.largeBlackBold,textAlign: TextAlign.end),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(x.questionSelections!.length!=0?x.questionSelections![index].text!:"",style: AppTextStyle.normalGray,textAlign: TextAlign.end),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                               x.type!.compareTo("selection")!=0&&widget.answers[indexAnswer].isTrue==0?
                              Center(child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: CustomAppButton(
                                  child: helper.mainTextView(texts: ["نعم ، أجبت بمثل ذلك"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  borderRadius: 6,
                                  color: AppColors.primary,
                                  onTap: () {
                                    setState(() {
                                      totalMark=totalMark+x.mark!;
                                      widget.answers[indexAnswer].isTrue=1;
                                      print(indexAnswer.toString()+"GGGGGGGGGGGG");
                                    });

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
          Expanded(child: Center(child:
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: CustomAppButton(
              child: helper.mainTextView(texts: [(widget.type!.compareTo("training")==0||finish)?"انهاء":"حفظ النتيجة"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
              padding: EdgeInsets.symmetric(vertical: 10),
              borderRadius: 12,
              color: AppColors.primary,
              onTap: () {
                if(widget.type!.compareTo("training")==0||finish)
                  {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => HomeUI()
                    ),(route){
                      return false;
                    });
                  }else{

                  quizResultModel=new QuizResultModel(mark: totalMark,execution_time: widget.executionQuizTime,
                      quize_id: widget.quizID,answers_arr: answersList);
                  setState(() {
                    _isLoading = true;
                  });
                  widget.bloc!.quizResult(
                      quizResultModel,
                      onError: (val){
                        print(val.toString());
                        print("EEEEEEEEE");
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      onData: (val){
                        setState(() {
                          _isLoading = false;
                        });
                        print("VVVVVVVV");
                        print(val);
                        if(val.code == 200)
                        {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (context) => HomeUI()
                          ),(route){
                            return false;
                          });
                        }
                        else if(val.code == 407){
                          setState(() {
                            finish=true;
                          });
                          showErrorDialog(context, val.message??'');
                        }else{
                          showErrorDialog(context, val.message??'');
                        }
                      }
                  );
                }




              },
              elevation: 1,
            ),
          ),
          ))
        ],
      ),
    );
  }
  @override
  void init() {

  }
}

