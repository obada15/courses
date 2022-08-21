import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Resources/ApiProvider.dart';
import 'package:Courses/Views/Course/Courses.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class SubjectTile extends StatelessWidget {
  final String ?imageURL, subjectName,subjectID;
  final Function function;


  SubjectTile({required this.imageURL, required this.subjectName,required this.subjectID,required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
      var back=await  pushNewScreen(context, screen:Courses(
          subjectID: subjectID!,
        ),
          withNavBar:false,
        );
        if(back!=null){
          print("GHHHHHHHHH");
          function();
        }
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 140,
            width: 128,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(right: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    height: 140,
                    placeholder:  (context, url) =>
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget:(context, url,dynamic) =>
                        SvgPicture.asset("assets/web.svg"),
                    imageUrl: imageURL!,
                    fit: BoxFit.fill,
                  ),
                )

              ],
            ),
          ),
          //   SizedBox(height: 14,),
          Text(subjectName!,style: GoogleFonts.poppins(color: Colors.black,fontSize: 16),),
        ],
      ),
    );
  }
}
