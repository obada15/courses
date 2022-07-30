import 'package:Courses/Extensions/StringsEx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DataStore.dart';
import '../Helper/AppColors.dart';
import '../Helper/AppTextStyle.dart';
import 'CustomAppButton.dart';
import 'eyeField/passwordfield.dart';

class HelperWidgets {
  Widget getTextField(controller, obscure, fNode, FocusNode? nNode, String hint,
          {bool readOnly = false,
          String ?pattern,
          String? errorMessage,
          bool isShowEye = false,
          Function ?onTap,
          TextInputType inputType = TextInputType.text,
          TextAlign textAlign = TextAlign.start,
          int maxLines = 1,
          int minLines = 1,
          color = AppColors.clear,
          BoxDecoration ?decoration,InputBorder ?border,Icon ?icon,double? height,TextStyle? inputStyle,TextStyle? hintStyle,InputBorder ?focusedBorder}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: height,
        child: PasswordField(
          color: AppColors.primary,
          minLines: minLines,
          maxLines: maxLines,
          readOnly: readOnly,
          focusedBorder:UnderlineInputBorder(
              borderSide:
              const BorderSide(width: 0, color: AppColors.primary),
              borderRadius: BorderRadius.circular(8.0)),
          border: border,
          inputStyle: inputStyle,
          hintStyle: hintStyle ?? AppTextStyle.normalLighterGray,
          icon: icon,
          suffixIconEnabled: isShowEye,
          suffixIcon:Icon(Icons.remove_red_eye,color: AppColors.primary,) ,
          floatingText: hint,
          hintText: hint,
          hasFloatingPlaceholder: true,
          pattern: pattern,
          errorMaxLines: 3,
          errorMessage: errorMessage,
          controller: controller,
          focusNode: fNode,
          nextFocusNode: nNode,
          keyboardType: inputType,
          textAlign: textAlign,
          onSubmit: (val) {
            if (nNode != null) nNode.requestFocus();
          },
        ),
      );
//       Container(
//         decoration: decoration != null ? decoration : BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                   color: AppColors.black.withOpacity(0.1),
//                   blurRadius: 6,
//                   spreadRadius: 0.5,
//                   offset: Offset(0, 6))
//             ]
//         ),
//         child: TextFormField(
//           autovalidate: true,
//           readOnly: readOnly,
//           keyboardType: inputType,
//           inputFormatters: inputFormatters,
//           maxLines: maxLines,
//           minLines: minLines,
//           onTap: onTap,
//           textAlign: textAlign,
//           controller: controller,
//           focusNode: fNode,
//           onFieldSubmitted: (val) {
//             if (nNode != null) nNode.requestFocus();
//           },
//           style: styleCyan ?  AppTextStyle.mediumCyan : AppTextStyle.normalBlack,
//           obscureText: obscure,
// //    cursorRadius: Radius.circular(0.7),
// //    cursorColor: Color.fromARGB(255, 52, 138, 192),
//           validator: (val) {
//             return;
//           },
//           decoration: textAlign == TextAlign.center ? InputDecoration(
//             hintText: hint,
//             hintStyle:  AppTextStyle.normalLighterGray,
//             filled: true,
//             fillColor: AppColors.lighterGray,
//             border: InputBorder.none,
//           ) : InputDecoration(
//               contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//               border: InputBorder.none,
//               labelText: hint,
//               labelStyle: styleCyan ? AppTextStyle.mediumCyanBold : AppTextStyle.mediumBlack),
//         ),
//       );

  background(BuildContext context, {bool hasTop = true}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: height - (hasTop ? MediaQuery.of(context).padding.top + 50 : 0),
        width: width,
        alignment: Alignment.bottomCenter,
        color: AppColors.white,
        child: Image.asset(
          'assets/images/background.png',
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

    mainAppBar(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey,
          String title,
          {bool showSettings = true,
          List<Widget>? actions,
          String? nameUI,
          double elevation = 1,
          bool showDrawer = false,PreferredSizeWidget ?bottom,TextEditingController ?controller,FocusNode ?focus}) =>
      AppBar(
        backgroundColor:
            (title ?? "").isEmpty ? AppColors.white : AppColors.white,

        centerTitle:controller!=null?false: true,
        bottom: bottom,

        toolbarHeight: (bottom==null)?(title ?? "").isEmpty ? 0 : 60:110, // Set this height
        elevation: (title ?? "").isEmpty ? 0 : elevation,
        iconTheme: IconThemeData(color: AppColors.black),
        actions: actions,
        brightness: Brightness.light,
         leadingWidth:controller!=null?0: 50,
         title:controller!=null? Container(
           padding: EdgeInsets.only(top: 5),
           child: getTextField(
               controller, null, focus, null, "search",
               border: OutlineInputBorder(
                   borderSide:
                   const BorderSide(width: 0, color: Colors.grey),
                   borderRadius: BorderRadius.circular(8.0)),
               height: 50),
         ):mainTextView(
              texts: [title], textsStyle: [AppTextStyle.largeBlackBold]),

        leading: Transform(
          transform: Matrix4.translationValues(8, 0, 0.0),
          child: ModalRoute.of(context)?.canPop == true
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: AppColors.gray,
                  ),

              onPressed: () {
            Navigator.of(context).pop();
          },
                )
                  : null,
        ),
      );
/*
  BottomNavigationBar mainBottomNavigationBar(BuildContext context,_onItemBottomNavigationBarTapped,{int selectedIndex = 0}) {

    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("home.png".assets),),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("event_.png".assets),),
            label: 'events'.tr,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("add_.png".assets),),
            label: 'new',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("chat.png".assets),),
            label: 'chat'.tr,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("settings.png".assets),),
            label: 'settings'.tr,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: AppColors.black,
        onTap: _onItemBottomNavigationBarTapped,showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyle.smallBlackBold,
        unselectedLabelStyle: AppTextStyle.smallBlack,
    );
  }

  showNetworkSheet(BuildContext context,
      {@required onSelected(String networkName, int networkId),
      bool optional = false}) {
    genBloc.f_getNetworks();
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.lightGray,
        builder: (context) => StreamBuilder<NetworkModel>(
            stream: genBloc.networksStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: ListView.builder(
                    itemCount: snapshot.data.data.length + (optional ? 1 : 0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          if (optional && index == snapshot.data.data.length) {
                            onSelected(null, null);
                          } else
                            onSelected(snapshot.data.data[index].name,
                                snapshot.data.data[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${(optional && index == snapshot.data.data.length) ? AppLocalizations.of(context).trans("notSelected") : snapshot.data.data[index].name}'),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
*/
  var lastNetworkId;
  empty(BuildContext context) {
    return Container();
  }
  double painterWidth(BuildContext context)  {
  return  MediaQuery.of(context).size.width - 20;
  }
  double painterHeight(BuildContext context)  {
    return painterWidth(context) * 9 / 16;
  }

  Widget noDataFound(BuildContext context, String title) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          decoration: helper.mainBoxDecoration(),
          width: width,
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              DrawerHeader(
                child: GestureDetector(
                  child: Image.asset(
                    "logo.png".assets,
                  ),
                ),
              ),
              helper.mainTextView(
                  texts: [title],
                  textsStyle: [AppTextStyle.normalCyanBold],
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  Widget mainTryAgainWidget(BuildContext context, retry) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          decoration: helper.mainBoxDecoration(),
          width: width,
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              DrawerHeader(
                child: GestureDetector(
                  child: Image.asset(
                    "logo.png".assets,
                  ),
                ),
              ),
              helper.mainTextView(
                  texts: ["something went wrong"],
                  textsStyle: [AppTextStyle.normalCyanBold],
                  textAlign: TextAlign.center),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CustomAppButton(
                  child: Text(
                    "try again",
                    style: AppTextStyle.normalWhiteBold,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  borderRadius: MediaQuery.of(context).size.width * 0.8 * 0.02,
                  color: AppColors.primary,
                  onTap: () {
                    retry();
                  },
                  elevation: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration alertBoxDecoration(
      {Color color = AppColors.primary,
      double animationValue = 2.0,
      Color shadowColor = AppColors.clear}) {
    return BoxDecoration(
      shape:
          BoxShape.circle, // You can use like this way or like the below line
      color: AppColors.white,
      border: Border.all(color: shadowColor),

      // boxShadow: [
      //   BoxShadow(
      //     color: shadowColor,
      //     blurRadius: animationValue,
      //     spreadRadius: animationValue,
      //   )
      // ],
    );
  }

  BoxDecoration mainBoxDecoration(
      {double radius = 8,
      Color color = AppColors.white,
      BoxBorder? border,
      Color shadowColor = AppColors.clear,
      bool onlyBottomShadow = false , bool onlyTopShadow = false}) {
    return BoxDecoration(
      borderRadius: !onlyBottomShadow && !onlyTopShadow
          ? BorderRadius.circular(radius)
          : ( onlyTopShadow ? BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius)) :
      BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius)) ),
      border: border,
      color: color,
      boxShadow: [
        BoxShadow(
          // color:shadowColor,
          color: shadowColor,
          spreadRadius: 4,
          blurRadius: 4,
          offset: Offset(0, 4),
        )
      ],
    );
  }

  BoxDecoration mainCardBoxDecoration({double radius = 0}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            AppColors.gray,
            Colors.white,
          ],
        ));
  }

  Widget mainAppHeader(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: AppColors.primary,
      ),
      height: 50,
      child: Center(
        child: helper.mainTextView(
            texts: [title], textsStyle: [AppTextStyle.largeWhiteSemiBold]),
      ),
    );
  }

  Widget mainTextView(
      {List<String> texts = const [],
      List<TextStyle> textsStyle = const [],
      textAlign: TextAlign.start,myOverflow:TextOverflow.ellipsis,}) {
    List<TextSpan> arrayTextSpan = [];
    for (int i = 0; i < texts.length; i++) {
      var style =
          i < textsStyle.length ? textsStyle[i] : AppTextStyle.normalBlack;
      arrayTextSpan.add(
        new TextSpan(text: texts[i], style: style),
      );
    }
    return RichText(
      textAlign: textAlign,overflow: myOverflow,
      text: new TextSpan(
        children: arrayTextSpan,
      ),
    );
  }
   void showToast(String text, GlobalKey<ScaffoldState> scaffoldstate) {

    scaffoldstate.currentState!.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'Ok',
            textColor: AppColors.white,
            disabledTextColor: AppColors.black,
            onPressed: scaffoldstate.currentState!.hideCurrentSnackBar),
      ),
    );
  }

}

final helper = HelperWidgets();
