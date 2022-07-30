import 'package:Courses/Bloc/HomeBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/SubjectTile.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHomeUI extends BaseUI<SubjectBloc> {
  @override
  _SubHomeUIState createState() => _SubHomeUIState();
  SubHomeUI() : super(bloc: SubjectBloc());

}

class _SubHomeUIState extends BaseUIState<SubHomeUI> {

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
        "Home",
        nameUI: "Home"
    );
  }

  @override
  Widget bodyUI() {
    return StreamBuilder<SubjectModel?>(
      //favorite api stream
        stream: widget.bloc!.dataController,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.subjects!.isEmpty) {
              return helper.noDataFound(
                  context, "no data found" + "\n" + "pls try again");
            }
            SubjectModel? data= snapshot.data;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                          itemCount: data!.subjects!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, int index) {
                            return SubjectTile(
                              imageURL:  data!.subjects![index].image,
                              subjectName:  data!.subjects![index].title,
                              subjectID:data!.subjects![index].id.toString() ,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Courses",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount:  data!.courses!.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, int index) {
                            return CourseTile(
                              imageURL:  data!.courses![index].image,
                              title: data!.courses![index].title,
                              isFree: data!.courses![index].is_free==1?true:false,
                              courseID: data!.courses![index].id.toString(),
                              price: data!.courses![index].price.toString(),

                            );
                          }),
                    ),
                  ],
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
