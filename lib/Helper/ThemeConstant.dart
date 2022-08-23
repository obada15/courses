import 'package:Science/Helper/AppColors.dart';
import 'package:flutter/material.dart';

 class ThemeConstant {
 /* static Color primaryColor = Color(0xff6758C0);
  static Color accentColor = Color(0xff20aebe);
  static Color shadowColor = Color(0xffa2a6af);

  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: 'Baloo',
      primarySwatch: Colors.deepPurple,
      colorScheme: ColorScheme.light(primary: Colors.deepPurple, secondary: Colors.teal),
      textTheme: TextTheme(
          headline3: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          ),
          headline4: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          )),
    );
  }
*/
  static BoxDecoration fullScreenBgBoxDecoration(
      {String backgroundAssetImage = "assets/logo.png"}) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(backgroundAssetImage), fit: BoxFit.contain),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)),border: Border.all(color: AppColors.silver, width: 2), );
  }

}
