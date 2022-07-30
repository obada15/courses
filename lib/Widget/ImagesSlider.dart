import 'dart:io';
import 'package:flutter/material.dart';

import '../Helper/AppColors.dart';
import '../Helper/AppConstant.dart';

class ImageSlider extends StatefulWidget {

  final List<dynamic> imageFile;

  ImageSlider(this.imageFile,{Key? key}):super(key:key);

  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    if(widget.imageFile.isEmpty)  return Container();
    return Container(
      height: 150,
      child: ListView.builder(
          itemCount: widget.imageFile.length ,
          itemBuilder: (context,index){
        return Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                widget.imageFile[index] is File?
                Image.file(
                  widget.imageFile[index],
                  height: 150,
                ):Image.network(
                  AppConstant.IMAGE_URL+widget.imageFile[index],
                  height: 150,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  widget.imageFile.removeAt(index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.cancel , color: AppColors.blue,),
              ),
            )
          ],
        );
      },
        scrollDirection: Axis.horizontal,
      ),
    );
  }


//  addToList(File file){
//
//  }
}
