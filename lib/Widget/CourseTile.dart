import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/Views/LessonsUI.dart';
import 'package:Courses/Widget/AppDialogs.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../views/VideoView.dart';

class CourseTile extends StatelessWidget {
  final String ?imageURL, title,description;
  final bool? isFree;
  final String courseID;
  final String price;
  final Function function;
  final int is_mine;
  final SubjectBloc bloc;

  CourseTile(
      { required this.imageURL,
  required this.title,
   required this.isFree,required this.courseID,
        required this.price,required this.description,
        required this.function,required this.is_mine,required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: new Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        elevation: 8.0,
        child: InkWell(
          onTap: () async {
            print("HHHHHHHHH " +is_mine.toString());
            if(is_mine==1){
              var back=await pushNewScreen(context, screen: LessonsUI(courseID:courseID ,description: description!,
                //courseUrl: courseURL,
              ),
                withNavBar:false,
              );
              if(back!=null){
                print("GHHHHHHHHH");
                function();
              }
            }else{
              displayTextInputDialog(context,
                  "This course is not available to you, if you want it, you have to buy its code",
                  "Insert your code",onOk: (code){
                     print(code);
                     print(courseID);
                    bloc!.InsertCode(code: code,
                        onError: (val){

                        },
                        onData: (val) async {
                          print("VVVVVVVV");
                          print(val);
                          if(val.code == 200)
                          {
                            var back=await pushNewScreen(context, screen: LessonsUI(courseID:courseID ,description: description!,
                              //courseUrl: courseURL,
                            ),
                              withNavBar:false,
                            );
                            if(back!=null){
                              print("GHHHHHHHHH");
                              function();
                            }
                          }
                          else showErrorDialog(context, val.message??'');
                        }
                    );
                  });
            }

          },
          // launch(snapshot.data[index].link),
          child: Stack(alignment: Alignment.bottomLeft, children: [
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
                imageUrl: imageURL!,
                fit: BoxFit.fill,
              ),
              height: 205,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title!,
                    style:
                        GoogleFonts.notoSans(fontSize: 16, color: Colors.white),
                  ),
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                ),
             Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isFree!? Row(
                        children: [
                          SvgPicture.asset("assets/icon.svg"),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Free",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      ):Text(
                        "price : "+ price,
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
