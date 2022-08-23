import 'package:Science/Helper/AppColors.dart';
import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  bool isSelected;
  String text;
  String optionText;
  int index;

  QuestionOption(this.index, this.optionText, this.text,
      {Key? key, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: [

          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: isSelected
                          ? AppColors.green
                          : Colors.white),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    optionText,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.black,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
