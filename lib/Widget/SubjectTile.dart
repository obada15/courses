import 'package:Courses/Helper/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/Courses.dart';

class SubjectTile extends StatelessWidget {
  final String ?imageURL, subjectName,subjectID;


  SubjectTile({required this.imageURL, required this.subjectName,required this.subjectID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Courses(
                    subjectID: subjectID!,
                  )),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 157,
        width: 128,
        decoration: BoxDecoration(
          color: AppColors.primary,
            borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.only(right: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //  SvgPicture.network(imageURL!),
            CachedNetworkImage(
              placeholder:  (context, url) =>
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              errorWidget:(context, url,dynamic) =>
                  SvgPicture.asset("assets/web.svg"),
              imageUrl: imageURL!,
              fit: BoxFit.fill,
            ),

            SizedBox(height: 14,),
            Text(subjectName!,style: GoogleFonts.poppins(color: Colors.white,fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
