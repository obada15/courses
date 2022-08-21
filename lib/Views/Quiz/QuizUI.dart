import 'package:Courses/Bloc/QuizBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/ThemeConstant.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Resources/ApiProvider.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/Quiz/ResultQuizUI.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:Courses/Widget/DiscoButton.dart';
import 'package:Courses/Widget/QuestionOption.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class QuizUI extends BaseUI<QuizBloc> {
  final String quizID;
  final String type;
  final double quizMark;
  @override
  _QuizUIState createState() => _QuizUIState();
  QuizUI({required this.quizID,required this.quizMark,required this.type}) : super(bloc: QuizBloc());

}

class _QuizUIState extends BaseUIState<QuizUI> {

  AppLifecycleState? state;
  Map<int, OptionSelection> _optionSerial = {};
  List<QuestionAnswer>answers=[];
  int questionIndex = 0;
  int maxQuestionCount = 0;
  TextEditingController answerController = TextEditingController();
  FocusNode answer = FocusNode();
  QuestionModel? data;
  late double totalMarks=0;
  CustomTimerController _controllerTime = new CustomTimerController();
  late String executionQuizTime;
  bool enter=false;
  @override
  void initState() {
    // TODO: implement initState
   // _controllerTime.start();
    super.initState();
  }
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "الاختبار",
        nameUI: "Quiz"
    );
  }

  @override
  Widget buildUI(BuildContext context) {
    return  bodyUI();
  }
  @override
  Widget bodyUI() {
    return StreamBuilder<QuestionModel?>(
      //favorite api stream
        stream: widget.bloc!.dataControllerQuestions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.questions!.isEmpty) {
              return helper.noDataFound(
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
            }

            data= snapshot.data;
            maxQuestionCount= snapshot.data!.questions!.length;
            if(enter==false)
              {
                for (var i = 0; i < data!.questions![questionIndex].questionSelections!.length; i++) {
                  if (answers.length == 0) {
                    _optionSerial[i] =
                        OptionSelection(String.fromCharCode(65 + i), false);
                  }
                }
                enter=true;
              }

            return  SingleChildScrollView(child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              color: AppColors.background,
              padding: EdgeInsets.all(10),
              //decoration: ThemeConstant.fullScreenBgBoxDecoration(),
              child: Column(
                children: [

                  quizQuestion(data!.questions![questionIndex]),
                  data!.questions![questionIndex].type!.compareTo("selection")==0?  questionOptions(data!.questions![questionIndex]):
                  Container(
                      height: MediaQuery.of(context).size.height/4,
                      alignment: Alignment.center,
                      decoration: ThemeConstant.roundBoxDeco(),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child:helper.getTextField(answerController, false, answer, answer,"الاجابة",inputType:
                        TextInputType.multiline,maxLines: 10,minLines: 10,textAlign: TextAlign.end,)
                      ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  CustomTimer(
                    controller: _controllerTime,
                    from: Duration(seconds: 1),
                    to: Duration(hours: 3),
                    interval: Duration(seconds: 1),
                    builder: (CustomTimerRemainingTime remaining) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${remaining.minutes}:${remaining.seconds}",
                            style: TextStyle(fontSize: 25.0,color: AppColors.primary,fontWeight: FontWeight.bold),
                          ),

                        ],
                      );
                    },
                    pausedBuilder: (CustomTimerRemainingTime remaining) {
                      executionQuizTime="${remaining.minutes}:${remaining.seconds}";
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${remaining.minutes}:${remaining.seconds}",
                            style: TextStyle(fontSize: 25.0,color: AppColors.primary,fontWeight: FontWeight.bold),
                          ),
                        ],);
                    },
                    onBuildAction: CustomTimerAction.auto_start,


                  ),
                  footerButton()
                ],
              ),
            ),);
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        });
  }
  Widget quizQuestion(QuestionM question) {
    return Container(
      alignment: Alignment.center,
      height:question.type!.compareTo("written")==0?MediaQuery.of(context).size.height/2.8:MediaQuery.of(context).size.height/4,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: ThemeConstant.roundBoxDeco(),
      child:question.image!=null? SingleChildScrollView(child: Column(
        children: [
          Container(
            child: CachedNetworkImage(
              placeholder:  (context, url) =>
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              errorWidget:(context, url,dynamic) =>
                  CachedNetworkImage(
                    imageUrl: "https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image/ca6212b7032c.png",
                    fit: BoxFit.fill,
                  ) ,
              imageUrl: question.image!,
              fit: BoxFit.fill,
            ),
            height: 200,
            //width: MediaQuery.of(context).size.width,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            question?.text ?? "",
            textAlign: TextAlign.end,

            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),):Text(
        question?.text ?? "",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget questionOptions(QuestionM question) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height/2.3,
      decoration: ThemeConstant.roundBoxDeco(),
      child: Column(
        children: List<QuestionSelectionsM>.from(question?.questionSelections ?? []).map((e) {
          int optionIndex = question!.questionSelections!.indexOf(e);
          var optWidget = GestureDetector(
            onTap: () {
              setState(() {
               // engine.updateAnswer(quiz.questions.indexOf(question!), optionIndex);
                for (int i = 0; i < _optionSerial.length; i++) {
                  _optionSerial[i]!.isSelected = false;
                }
                _optionSerial.update(optionIndex, (value) {
                  value.isSelected = true;
                 // print("SSSSSSSSSSSSSSSS");
                //  print(question!.questionSelections![optionIndex].text);
               bool isExist=false;
              int quIndex=0;
                  for(int i=0;i<answers.length;i++)
                    {
                      if(answers[i].questionID==data!.questions![questionIndex].id)
                        {
                          isExist=true;
                          quIndex=i;
                        }
                    }
                  if(isExist)
                    {

                      if(question!.questionSelections![optionIndex].is_true==1)
                        {
                          totalMarks=totalMarks+data!.questions![questionIndex].mark!;
                        }else{

                        if(answers[quIndex].isTrue==1)
                          {
                            totalMarks=totalMarks-data!.questions![questionIndex].mark!;
                          }
                        else{

                        }

                      }
                      answers[quIndex]=QuestionAnswer(int.parse(widget.quizID), data!.questions![questionIndex].id!, value.optionText,question!.questionSelections![optionIndex].text!,
                          question!.questionSelections![optionIndex].is_true!);
                    }else{
                    answers.add(QuestionAnswer(int.parse(widget.quizID), data!.questions![questionIndex].id!, value.optionText,question!.questionSelections![optionIndex].text!,
                        question!.questionSelections![optionIndex].is_true!));
                    if(question!.questionSelections![optionIndex].is_true==1)
                    {
                      totalMarks=totalMarks+data!.questions![questionIndex].mark!;
                    }
                  }
                  for(int i=0;i<answers.length;i++)
                    {
                      print(answers[i].questionID.toString()+"  +  "+answers[i].textOption+"  +  "+answers[i].textAnswer+"  +  "+answers[i].isTrue.toString());
                    }

                  return value;
                });
              });
            },
            child: QuestionOption(
              optionIndex,
              _optionSerial[optionIndex]!.optionText,
              e.text!,
              isSelected: _optionSerial[optionIndex]!.isSelected,
            ),
          );
          return optWidget;
        }).toList(),
      ),
    );
  }

  Widget footerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DiscoButton(
          onPressed: () {
           // Navigator.pop(context);
            back();
          },
          child: Text(
            "السابق",
            style: TextStyle(fontSize: 20),
          ),
          width: 130,
          height: 50,
        ),
        DiscoButton(
          onPressed: () {
            //engine.next();
            next();
          },
          child: Text(
            questionIndex+1==maxQuestionCount?"انهاء":  "التالي",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          isActive: true,
          width: 130,
          height: 50,
        ),
      ],
    );
  }

  void next() {
    if(questionIndex+1==maxQuestionCount)
      {
        if(data!.questions![questionIndex].type!.compareTo("written")==0) {
          answers.add(QuestionAnswer(
              int.parse(widget.quizID), data!.questions![questionIndex].id!, "",
              answerController.text,
              0));
        }
        else{
          bool isExist=false;
          for(int i=0;i<answers.length;i++)
          {
            if(answers[i].questionID==data!.questions![questionIndex].id!)
            {
              isExist=true;
            }
          }
          if(!isExist)
          {
            answers.add(QuestionAnswer(int.parse(widget.quizID), data!.questions![questionIndex].id!,"",answerController.text,
                0));
          }

        }
        answerController.text="";
        _controllerTime.pause();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultQuizUI(int.parse(widget.quizID),totalMarks,widget.quizMark,data,executionQuizTime,answers,widget.type),
          ),
        );
      }
    else{
      if(data!.questions![questionIndex].type!.compareTo("written")==0)
        {
          answers.add(QuestionAnswer(int.parse(widget.quizID), data!.questions![questionIndex].id!,"",answerController.text,
             0));
          answerController.text="";
        }else{
        bool isExist=false;
        for(int i=0;i<answers.length;i++)
          {
            if(answers[i].questionID==data!.questions![questionIndex].id!)
              {
                isExist=true;
              }
          }
        if(!isExist)
          {
            answers.add(QuestionAnswer(int.parse(widget.quizID), data!.questions![questionIndex].id!,"",answerController.text,
                0));
          }

      }
      setState(() {
        if(questionIndex!=(maxQuestionCount-1))
          questionIndex++;
      });
      for (var i = 0; i < data!.questions![questionIndex].questionSelections!.length; i++) {
        if(answers.length==0)
        {
          _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
        }
        else{
          bool isExist=false;

          for (var j = 0; j < answers.length; j++) {

            if(answers[j].questionID==data!.questions![questionIndex].id)
            {
              if(answers[j].textOption.compareTo(_optionSerial[i]!.optionText)!=0)
                _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
              else
                _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),true );
              isExist=true;
            }

          }
          if(isExist==false)
          {
            _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
          }
        }
      }
    }

  }
  void back() {
    setState(() {
      if(questionIndex!=0)
      questionIndex--;
    });
    for (var i = 0; i < data!.questions![questionIndex].questionSelections!.length; i++) {
      if(answers.length==0)
      {
        _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
      }
      else{
        bool isExist=false;
        for (var j = 0; j < answers.length; j++) {

          if(answers[j].questionID==data!.questions![questionIndex].id)
          {
            if(answers[j].textOption.compareTo(_optionSerial[i]!.optionText)!=0)
              _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
            else
              _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),true );

            isExist=true;
          }

        }
        if(isExist==false)
          {
            _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i),false );
          }
      }

    }
  }

  @override
  void retry() {
    super.retry();
    widget.bloc!.dataController.sink.add(null);
    widget.bloc!.getQuestionsRequest(widget.quizID);
  }
  @override
  void init() {
    widget.withRefresh=false;
    retry();
  }

}
