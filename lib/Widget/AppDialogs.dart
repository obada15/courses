import 'package:flutter/material.dart';
import '../DataStore.dart';
import '../Helper/AppColors.dart';
import '../Helper/AppTextStyle.dart';
import 'CustomAppButton.dart';
import 'HelperWigets.dart';

Future<T?> showErrorDialog<T>(BuildContext? context,String? msg,{bool isError = true}) async{

  return await showDialog<T>(context: context! , builder: (context){
    return AlertDialog(
      title: Text(msg!=null?msg:"wrong" , style: AppTextStyle.normalBlackBold.copyWith(color:isError? AppColors.red:AppColors.black),textAlign: TextAlign.center,),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child:
          InkWell(
            // elevation: 0,
              onTap: (){
                Navigator.of(context).pop(true);
              },
              child: Center(child: Text("ok",style: AppTextStyle.normalBlackBold,textAlign: TextAlign.center,),)
          ),width: 70,height: 30,)
        ],
      ),
    );
  },barrierDismissible: false,);
}
Future<T?> showAlertDialog<T>(BuildContext? context,String? msg,{bool isError = true}) async{

  return await showDialog<T>(context: context! , builder: (context){
    return AlertDialog(
      title: Text(msg!=null?msg:"wrong" , style: AppTextStyle.normalBlackBold.copyWith(color:isError? AppColors.green:AppColors.black),textAlign: TextAlign.center,),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child:
          InkWell(
            // elevation: 0,
              onTap: (){
                Navigator.of(context).pop(true);
              },
              child: Center(child: Text("موافق",style: AppTextStyle.normalBlackBold,textAlign: TextAlign.center,),)
          ),width: 70,height: 30,)
        ],
      ),
    );
  },barrierDismissible: false,);
}

Future<T?> displayAlertDialog<T>(BuildContext context,String title,String body,{onOk,onCancel}) async{
  // TextEditingController _textFieldController = TextEditingController();
  // FocusNode _textFieldF = FocusNode();
  return await showDialog<T>(context: context , builder: (context){
    return AlertDialog(
      title: Text(title , style: AppTextStyle.normalBlackBold ,textAlign: TextAlign.center,),
      content: Text(body , style: AppTextStyle.normalBlackBold ,textAlign: TextAlign.center,),
      actions: <Widget>[
        CustomAppButton(
          elevation: 0,
          color: AppColors.white,
          onTap: (){
            onCancel();
            Navigator.of(context).pop(true);
          },
          child: Text("cancel",style: AppTextStyle.normalBlackBold.copyWith(
              color:AppColors.black
          ),),
        ),
        SizedBox(width: 16,),
        CustomAppButton(
          elevation: 0,
          color: AppColors.white,
          onTap: (){
            onOk();
            Navigator.of(context).pop(true);
          },
          child: Text("ok",style: AppTextStyle.normalBlackBold.copyWith(
              color:AppColors.black
          ),),
        ),
        SizedBox(width: 10,),
      ],
    );
  });
}

Future<void> displayTextInputDialog(BuildContext context,String title,String placeHolder,{onOk,onCancel}) async {
  TextEditingController _textFieldController = TextEditingController();
  FocusNode _textFieldF = FocusNode();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text( title, style: AppTextStyle.normalBlackBold ,textAlign: TextAlign.center,),
          content:Directionality(
            textDirection: TextDirection.rtl,
            child:helper.getTextField(_textFieldController, false, _textFieldF, null,placeHolder),
          ),
          actions: <Widget>[
            CustomAppButton(
              elevation: 0,
              color: AppColors.white,
              onTap: (){
               // onCancel(_textFieldController.text);
                Navigator.of(context).pop(true);
              },
              child: Text("الغاء",style: AppTextStyle.normalBlackBold.copyWith(
                  color: AppColors.black
              ),),
            ),
            SizedBox(width: 16,),
            Padding(padding: EdgeInsets.only(bottom: 5),child: CustomAppButton(
              elevation: 0,
              color: AppColors.white,
              onTap: (){
                if (_textFieldController.text.isNotEmpty){
                  onOk(_textFieldController.text);
                }
                Navigator.of(context).pop(true);
              },
              child: Text("موافق",style: AppTextStyle.normalBlackBold.copyWith(
                  color:  AppColors.black
              ),),
            ),),
            SizedBox(width: 10,),

          ],
        );
      });
}