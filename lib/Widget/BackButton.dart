import 'package:flutter/material.dart';
class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/back.png" , height: 25,width: 25 ,),
      ),
    );
  }
}

