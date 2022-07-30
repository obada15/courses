import 'package:flutter/material.dart';

import '../Helper/AppTextStyle.dart';

class DialogListSLWidget extends StatelessWidget {
  final String title;
  final List<Widget> itemsWidget;

  const DialogListSLWidget({Key? key, required this.title, required this.itemsWidget})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(dialogBackgroundColor: Colors.white),
        child: AlertDialog(
          title: Text(title,
              textAlign: TextAlign.end,
              style: AppTextStyle.normalCyanBold
          ),
          content: Container(
            height: itemsWidget.length*50.0, // Change as per your requirement
            width: MediaQuery. of(context). size. width *0.5, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemsWidget.length,
              itemBuilder: (BuildContext context, int index) {
                return itemsWidget[index];
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('cancel',
                    style: AppTextStyle.normalCyanBold),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ));
  }
}
