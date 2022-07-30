

import 'package:Courses/Bloc/AuthBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Extensions/StringsEx.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Helper/Utils.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/HomeUI.dart';
import 'package:Courses/Views/SubHomeUI.dart';
import 'package:Courses/Views/SignUpUI.dart';
import 'package:Courses/Widget/AppDialogs.dart';
import 'package:Courses/Widget/CustomAppButton.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInIU extends BaseUI<AuthBloc> {
  final String type;

  @override
  _SignInIUState createState() => _SignInIUState();

  SignInIU({this.type = "User"}):super(bloc:AuthBloc());
}
class _SignInIUState extends BaseUIState<SignInIU> {

  FocusNode phone = FocusNode();
  FocusNode password = FocusNode();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool  _isLoading = false;
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, scaffoldKey,"");
  }

  @override
  Widget buildUI(BuildContext context) {
    // TODO: implement buildUI
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: helper.mainBoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height *0.2,
              ),
              Container(
                // width: MediaQuery.of(context).size.height * 0.3 * 16/11,
                height: MediaQuery.of(context).size.height * 0.22 ,
                child: Image.asset(
                    "logo.png".assets,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *0.08,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    helper.getTextField(phoneController, false, phone, password,"phone",inputType:
                    TextInputType.phone,pattern: Utils.getNumberPattern,errorMessage: "phone validator"),
                    SizedBox(
                      height: 8,
                    ),
                    helper.getTextField(passwordController, true, password, null,'password',isShowEye: true),
                    SizedBox(height: 64,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CustomAppButton(
                        child: helper.mainTextView(texts: ["login"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
                        padding: EdgeInsets.symmetric(vertical: 13),
                        borderRadius: 12,
                        color: AppColors.primary,
                        onTap: () {
                          print("DDDDDDDDDDD");

                          if(!validate()) return;
                          setState(() {
                            _isLoading = true;
                          });
                          widget.bloc!.login(
                              email: phoneController.text,
                              password: passwordController.text,
                              onError: (val){
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              onData: (val){
                                setState(() {
                                  _isLoading = false;
                                });
                                print("VVVVVVVV");
                                print(val);
                                if(val.code == 200)
                                {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                      builder: (context) => HomeUI()
                                  ),(route){
                                    return false;
                                  });
                                }
                                else showErrorDialog(context, val.message??'');
                              }
                          );


                        },
                        elevation: 1,
                      ),
                    ),
                    SizedBox(height: 24,),
                    InkWell(
                      child: helper.mainTextView(texts: ["Do you have an account?"],textAlign: TextAlign.start,textsStyle: [
                        TextStyle(color: AppColors.primary,fontSize: 18)]),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpUI()
                        ));
                      },
                    ),
                    SizedBox(height: 24,),

                  ],
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void init() {
    widget.withRefresh=false;
  }


  bool validate(){
    if(Utils.isTextEmpty(phoneController))
      return emptyAlert('user phone');
    if(Utils.isTextEmpty(passwordController))
      return emptyAlert('password');
    if(passwordController.text.length < 6){
      showErrorDialog(context, "lessThan6");
      return false;
    }

    return true;

  }
  bool emptyAlert(String key)
  {
    showErrorDialog(context, "empty "+key);
    return false;
  }

}