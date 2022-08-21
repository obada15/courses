
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

class MyCourses extends BaseUI<SubjectBloc> {
  final String subjectID;
  @override
  _MyCoursesState createState() => _MyCoursesState();
  MyCourses({required this.subjectID}) : super(bloc: SubjectBloc());

}

class _MyCoursesState extends BaseUIState<MyCourses> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("FFFFFFFFFFFFFFF");
   // print(dataStore.user!.data!.token);
  }
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "دوراتي",
        nameUI: "My Courses"
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
    return StreamBuilder<CourseModel?>(
      //favorite api stream
        stream: widget.bloc!.dataMyCoursesController,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.courses!.isEmpty) {
              return helper.noDataFound(
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
            }
            CourseModel? data= snapshot.data;

            return SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data!.courses!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CourseTile(
                        imageURL: data!.courses![index].image,
                        title: data!.courses![index].title,
                        isFree: data!.courses![index].is_free==1?true:false,
                        courseID: data!.courses![index].id.toString(),
                        price: data!.courses![index].price.toString(),
                        description: data!.courses![index].description.toString(),
                        function: (){
                          retry();
                        },
                        is_mine:data!.courses![index].is_mine! ,
                        bloc: widget.bloc!,
                      ),
                    );
                  },
                ),
              ),
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
    widget.bloc!.dataMyCoursesController.sink.add(null);
    widget.bloc!.getMyCoursesRequest();
  }
  @override
  void init() {
    retry();
  }

}
