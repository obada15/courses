

import 'dart:io';

import 'package:Courses/Bloc/AuthBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Extensions/StringsEx.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Helper/Utils.dart';
import 'package:Courses/Models/User.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Views/SubHomeUI.dart';
import 'package:Courses/Widget/AppDialogs.dart';
import 'package:Courses/Widget/CustomAppButton.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpUI extends BaseUI<AuthBloc> {
  @override
  _SignUpUIState createState() => _SignUpUIState();

  SignUpUI():super(bloc:AuthBloc());
}
class _SignUpUIState extends BaseUIState<SignUpUI>{

  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode confirmPassword = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode firstName = FocusNode();
  FocusNode lastName = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool  _isLoading = false;
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, scaffoldKey,"Sign Up");
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
                /* SizedBox(
                  height: MediaQuery.of(context).size.height *0.07,
                ),
               Container(
                  // width: MediaQuery.of(context).size.height * 0.3 * 16/11,
                  height: MediaQuery.of(context).size.height * 0.22 ,
                  child: Image.asset(
                    "logo.png".assets,
                  ),
                ),*/
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.02,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      helper.getTextField(firstNameController, false, firstName, firstName,"first name",inputType:
                      TextInputType.text),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(lastNameController, false, lastName, lastName,"last name",inputType:
                      TextInputType.text),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(emailController, false, email, email,"email",inputType:
                      TextInputType.emailAddress,pattern: Utils.getEmailPattern,errorMessage: "email validator"),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(phoneController, false, phone, phone,"phone",inputType:
                      TextInputType.phone,pattern: Utils.getNumberPattern,errorMessage: "phone validator"),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(passwordController, true, password, null,'password',isShowEye: true),
                      SizedBox(
                        height: 8,
                      ),
                      helper.getTextField(confirmPasswordController, true, confirmPassword, null,'Confirm Password',isShowEye: true ),
                      SizedBox(
                        height: 20,
                      ),
                      showImage(""),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(height: 34,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: CustomAppButton(
                          child: helper.mainTextView(texts: ["Sign up"],textsStyle: [AppTextStyle.largeWhiteSemiBold],textAlign: TextAlign.center),
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
                              ,email:emailController.text ,idImage:file!.path,displayImageName: file!.path.split('/').last, );
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
                                    showAlertDialog(context,val.message);
                                    /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context) => Home()
                                    ),(route){
                                      return false;
                                    });*/
                                    print("AAAAAAAAAAA");

                                  }
                                  else showErrorDialog(context, val.message??'');
                                }
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
  Future<File>? imageFile;
  late XFile? file=new XFile("");

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    file = await _picker.pickImage(source: ImageSource.camera);
    imageFile=File(file!.path).create();


    setState(() {
      print("mmmmmmmmm"+imageFile.toString());
      print("mmmmmmmmm"+file!.path.toString());
    });
  }

  Widget showImage(String image) {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            child: Container(
                child: new Container(
                  width: 374,
                  height: 207.0,
                  decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      image: new MemoryImage(snapshot.data!.readAsBytesSync()),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                    border: new Border.all(
                      color: AppColors.gray,
                      width: 1.0,
                    ),
                  ),
                )
            ),
            onTap: () {
              getImage();
            },
          );
        }
        else if (null == snapshot.data && image != null && image.isNotEmpty) {
          return InkWell(
            child:  new Container(
              width: 374,
              height: 207.0,
              decoration: new BoxDecoration(
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  image: new NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                border: new Border.all(
                  color: AppColors.gray,
                  width: 1.0,
                ),
              ),
            ),
            onTap: () {
              getImage();
            },
          );
        }
        else if (null == snapshot.data && (image == null || image.isEmpty)) {
          print("sasa"+image);

          return InkWell(
            child: Container(
                child:Center(

                    child:   Container(
                        width: 374,
                        height: 207.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color:AppColors.gray, width: 1),
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.transparent],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                        ),
                        child: Center(
                          child:  Text(
                            "No Image to show !",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width>600?24:20, color: AppColors.gray343),
                          ),
                        )
                    )
                )
            ),
            onTap: () {
              getImage();
            },
          );
        }
        else return Container();
      },
    );
  }
  @override
  void init() {
    widget.withRefresh=false;
  }


  bool validate(){
    if(Utils.isTextEmpty(firstNameController))
      return emptyAlert('user first name');
    if(Utils.isTextEmpty(lastNameController))
      return emptyAlert('user last name');
    if(Utils.isTextEmpty(phoneController))
      return emptyAlert('user phone');
    if(Utils.isTextEmpty(passwordController))
      return emptyAlert('password');
    if(Utils.isTextEmpty(confirmPasswordController))
      return emptyAlert('confirm password');
    if(passwordController.text.length < 6){
      showErrorDialog(context, "lessThan6");
      return false;
    }
    if(confirmPasswordController.text.length < 6){
      showErrorDialog(context, "lessThan6");
      return false;
    }
    if(confirmPasswordController.text.compareTo(passwordController.text)!=0){
      showErrorDialog(context, "confirm password != password");
      return false;
    }
    if(file==null)
      {
        showErrorDialog(context, "select image");
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