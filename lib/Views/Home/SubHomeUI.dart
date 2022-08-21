import 'package:Courses/Bloc/GeneralBloc.dart';
import 'package:Courses/Bloc/HomeBloc.dart';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/SubjectTile.dart';
import 'package:Courses/Widget/CourseTile.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
        "الرئيسية",
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
                  context, "لا يوجد معلومات" + "\n" + "نرجوا المحاولة مرة اخرى");
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
                        top: 30,
                      ),
                      width: double.infinity,
                      height: 225,
                      child: ListView.builder(
                          itemCount: data!.subjects!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, int index) {
                            return SubjectTile(
                              imageURL:  data!.subjects![index].image,
                              subjectName:  data!.subjects![index].title,
                              subjectID:data!.subjects![index].id.toString() ,
                              function: (){
                                retry();
                              },
                            );
                          }),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topRight,
                      child: Text(
                        "الدورات الاكثر شيوعا",textAlign: TextAlign.end,
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
                              description: data!.courses![index].description.toString(),
                              function: (){
                                retry();
                              },
                              is_mine:data!.courses![index].is_mine! ,
                              bloc: widget.bloc!,
                            );
                          }),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topRight,
                      child: Text(
                        "الدورات المجانية",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount:  data!.freeCourses!.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, int index) {
                            return CourseTile(
                              imageURL:  data!.freeCourses![index].image,
                              title: data!.freeCourses![index].title,
                              isFree: data!.freeCourses![index].is_free==1?true:false,
                              courseID: data!.freeCourses![index].id.toString(),
                              price: data!.freeCourses![index].price.toString(),
                              description: data!.freeCourses![index].description.toString(),
                              function: (){
                                retry();
                              },
                              is_mine:1 ,
                              bloc: widget.bloc!,
                            );
                          }),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          //padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            child: Image.asset("assets/telegram.png",width: 60,height: 60,),
                            onTap: (){
                              launchUrl(data.telegram_link.toString());
                              print(data.telegram_link.toString());
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        Container(
                          //padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Image.asset("assets/whatsapp.png",width: 60,height: 60,),
                              onTap: (){
                                print(data.whatsapp_link.toString());
                                launchUrl(data.whatsapp_link.toString());
                              },
                            )
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
  void launchUrl(String url) async {
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
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
