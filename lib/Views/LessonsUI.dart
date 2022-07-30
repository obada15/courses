
import 'package:Courses/Bloc/LessonBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Models/LessonModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/VideoView.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../Helper/AppTextStyle.dart';
import 'dart:math' as math;

class LessonsUI extends BaseUI<LessonBloc> {
  final String courseID;
  @override
  _LessonsUIState createState() => _LessonsUIState();
  LessonsUI({required this.courseID}) : super(bloc: LessonBloc());

}

class _LessonsUIState extends BaseUIState<LessonsUI> with SingleTickerProviderStateMixin{

  List<LessonWidget> lessons = [];
  List<Widget> cardsLessons = [];
  late TabController _controller;
  /*List<String>videos=["Lesson biology1","Lesson biology2","Lesson biology3"];
  List<String>videos1=["Lesson Genetics1","Lesson Genetics2"];
  List<String>videos2=["Lesson Neurology1","Lesson Neurology2","Lesson Neurology3"];*/
  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "Lessons",
        nameUI: "Lessons",
    );
  }
//
  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _controller,
        indicatorColor: AppColors.orange,
        labelColor: AppColors.orange ,
        unselectedLabelColor: AppColors.primary,
        labelStyle: TextStyle(fontWeight: FontWeight.w800),
        tabs: [
          Tab(
            text: "المناهج",
          ),
          Tab(
            text: "الوصف",
          )
        ],
      ),
      body: bodyUI()
    ); }

  @override
  Widget bodyUI() {
    return StreamBuilder<LessonModel?>(
      //favorite api stream
        stream: widget.bloc!.dataController,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.lessons!.isEmpty) {
              return helper.noDataFound(
                  context, "no data found" + "\n" + "pls try again");
            }
            LessonModel? data= snapshot.data;
            lessons.clear();
            cardsLessons.clear();
            for(int i=0;i<data!.lessons!.length;i++)
              {
                lessons.add(new LessonWidget(data.lessons![i].title!,data.lessons![i].videos));
              }

            for(int i=0;i<lessons.length;i++)
            {
              List<Widget> list=[];
              for(int j=0;j<lessons[i].videos!.length;j++)
              {
                list.add(Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(Icons.play_circle_fill,color: AppColors.primary,),
                          SizedBox(width: 10,),
                          Text(lessons[i].videos![j].title!,style: AppTextStyle.mediumBlackBold,),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoView(
                              videoUrl: lessons[i].videos![j].link!,
                            ),
                          ),
                        );
                      },
                    )
                ),);
              }
              cardsLessons.add(
                Card3(lessons[i].title,Column(children: list,)),
              );
            }
            return TabBarView(
              controller: _controller,
              children: [
                Column(
                    children: cardsLessons
                ),
                Center(child: Text("Soon .. ",style: TextStyle(color: AppColors.primary,fontSize: 20),),)
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        });
  }

  @override
  void retry() {
    super.retry();
    widget.bloc!.dataController.sink.add(null);
    widget.bloc!.getRequest(widget.courseID);
  }
  @override
  void init() {
    retry();
  }
}
class Card3 extends StatelessWidget {
  final String title;
  final Widget children;

  const Card3(this.title, this.children);
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }


    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: children
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
class LessonWidget{
  late String title;
  late List<VideoM>?videos;
  LessonWidget(this.title,this.videos);
}