
import 'package:Science/Bloc/LessonBloc.dart';

import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Helper/ThemeConstant.dart';
import 'package:Science/Helper/Utils.dart';
import 'package:Science/Models/LessonModel.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Views/Course/VideoView.dart';
import 'package:Science/Widget/CourseTile.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../Helper/AppTextStyle.dart';
import 'dart:math' as math;

class LessonsUI extends BaseUI<LessonBloc> {
  final String courseID;
  final String description;
  @override
  _LessonsUIState createState() => _LessonsUIState();
  LessonsUI({required this.courseID,required this.description}) : super(bloc: LessonBloc());

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
        "الدروس",
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
            text: "الدروس",
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
            if (snapshot.data == null ) {
              return helper.noDataFound(
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
            }
            LessonModel? data= snapshot.data;
            lessons.clear();
            cardsLessons.clear();
            for(int i=0;i<data!.lessons!.length;i++)
              {
                lessons.add(new LessonWidget(data.lessons![i].title!,data.lessons![i].videos,data.lessons![i].description!));
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(lessons[i].videos![j].title!,style: AppTextStyle.mediumBlackBold,),
                          SizedBox(width: 10,),
                          Icon(Icons.play_circle_fill,color: AppColors.primary,),
                        ],
                      ),
                      onTap: () async {
                        var back=await pushNewScreen(context, screen: VideoView(
                          videoUrl: Utils.testInput(lessons[i].videos![j].link!),
                          description:lessons[i].description,
                        ),
                          withNavBar:false,
                        );
                        if(back!=null){
                          retry();
                        }

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
                SingleChildScrollView(child: Column(
                    children: cardsLessons
                ),),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    decoration: ThemeConstant.roundBoxDeco(),
                    child:SingleChildScrollView(
                      child: Padding(child:
                      Text(widget.description,
                        style: TextStyle(color: AppColors.primary,fontSize: 20,),textAlign: TextAlign.end,)
                        ,padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),),
                    )

                ),

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
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [

                            Expanded(
                              child: Text(
                                title,textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_left,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(left: 5),
                                hasIcon: false,
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
  late String description;
  late List<VideoM>?videos;
  LessonWidget(this.title,this.videos,this.description);
}