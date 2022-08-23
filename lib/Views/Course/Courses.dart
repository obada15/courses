
import 'package:Science/Bloc/SubjectBloc.dart';
import 'package:Science/DataStore.dart';
import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Models/SubjectModel.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Widget/CourseTile.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';

class Courses extends BaseUI<SubjectBloc> {
  final String subjectID;
  @override
  _CoursesState createState() => _CoursesState();
  Courses({required this.subjectID}) : super(bloc: SubjectBloc());

}

class _CoursesState extends BaseUIState<Courses> {

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
        "Courses",
        nameUI: "Courses"
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
        stream: widget.bloc!.dataCoursesController,
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
    widget.bloc!.dataCoursesController.sink.add(null);
    widget.bloc!.getCoursesRequest(widget.subjectID);
  }
  @override
  void init() {
    retry();
  }

}
