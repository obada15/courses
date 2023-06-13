

import 'dart:io';

import 'package:Science/Bloc/AuthBloc.dart';
import 'package:Science/DataStore.dart';
import 'package:Science/Extensions/StringsEx.dart';
import 'package:Science/Helper/AppColors.dart';
import 'package:Science/Helper/AppTextStyle.dart';
import 'package:Science/Helper/Utils.dart';
import 'package:Science/Models/User.dart';
import 'package:Science/Views/Auth/SignInUI.dart';
import 'package:Science/Views/BaseUI.dart';
import 'package:Science/Views/Home/HomeUI.dart';
import 'package:Science/Views/Home/SubHomeUI.dart';
import 'package:Science/Widget/AppDialogs.dart';
import 'package:Science/Widget/CustomAppButton.dart';
import 'package:Science/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpUI extends BaseUI<AuthBloc> {
  @override
  _SignUpUIState createState() => _SignUpUIState();

  SignUpUI():super(bloc:AuthBloc());
}
class _SignUpUIState extends BaseUIState<SignUpUI>{

  FocusNode password = FocusNode();
  FocusNode confirmPassword = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode firstName = FocusNode();
  FocusNode lastName = FocusNode();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool  _isLoading = false;
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, scaffoldKey,"انشاء حساب",nameUI: "Sign Up");
  }

  @override
  Widget buildUI(BuildContext context) {
    // TODO: implement buildUI
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.1,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: helper.getTextField(firstNameController, false, firstName, firstName,"الاسم",inputType:
                        TextInputType.text),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child:  helper.getTextField(lastNameController, false, lastName, lastName,"الكنية",inputType:
                        TextInputType.text),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child:helper.getTextField(phoneController, false, phone, phone,"رقم الهاتف",inputType:
                        TextInputType.phone,pattern: Utils.getNumberPattern,errorMessage: "phone validator",),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: helper.getTextField(passwordController, true, password, null,'كلمة السر',isShowEye: true),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child:helper.getTextField(confirmPasswordController, true, confirmPassword, null,'تاكيد كلمة السر',isShowEye: true ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(height: 100,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: CustomAppButton(
                          child: helper.mainTextView(texts: ["انشاء"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
                          padding: EdgeInsets.symmetric(vertical: 13),
                          borderRadius: 12,
                          color: AppColors.primary,
                          onTap: () {
                            if(!validate()) return;
                            setState(() {
                              _isLoading = true;
                            });
                            User user= new User(firstName:firstNameController.text ,lastName:lastNameController.text
                              ,phone:phoneController.text ,password:passwordController.text
                              ,/*idImage:file!.path,displayImageName: file!.path.split('/').last,*/ );
                            widget.bloc!.signUp(
                                 user: user,
                                onError: (val){
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                onData: (val){

                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if(val.code == 200)
                                  {
                                    print(val);
                                    print("44444444444444444");
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context) => HomeUI()
                                    ),(route){
                                      return false;
                                    });

                                  }
                                  else showErrorDialog(context, val.message.toString()??'');
                                },
                            );


                          },
                          elevation: 1,
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
  @override
  void init() {
    widget.withRefresh=false;
  }


  bool validate(){
    if(Utils.isTextEmpty(firstNameController))
      return emptyAlert('اسم المستخدم');
    if(Utils.isTextEmpty(lastNameController))
      return emptyAlert('الكنية');
    if(Utils.isTextEmpty(phoneController))
      return emptyAlert('رقم الهاتف');
    if(Utils.isTextEmpty(passwordController))
      return emptyAlert('كلمة السر');
    if(Utils.isTextEmpty(confirmPasswordController))
      return emptyAlert('تاكيد كلمة السر');
    if(passwordController.text.length < 6){
      showErrorDialog(context, "عدد المحارف اقل من 6");
      return false;
    }
    if(confirmPasswordController.text.length < 6){
      showErrorDialog(context, "عدد المحارف اقل من 6");
      return false;
    }
    if(confirmPasswordController.text.compareTo(passwordController.text)!=0){
      showErrorDialog(context, "كلمة السر لا تطابق تاكيد كلمة السر");
      return false;
    }
    return true;

  }
  bool emptyAlert(String key)
  {
    showErrorDialog(context,key+ " فارغ ");
    return false;
  }

}