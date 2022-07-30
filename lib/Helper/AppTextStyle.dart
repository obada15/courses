import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppFontsSize.dart';

abstract class AppTextStyle {

  static final largeWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumWhiteSemiBold= TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static final largeWhiteSemiBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static String segoePrint = 'Segoe Print';
  static String cairo = 'Cairo';
  static String nova = 'Nova';
  static String segoeUI = 'Segoe UI';
  static String arial = 'Arial';
  static String primaryFont = arial;


  static final mediumPrimary = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      color: AppColors.primary,
      fontFamily: AppTextStyle.primaryFont);
  static final mediumPrimaryBold = TextStyle(
      color: AppColors.primary,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);

  static final normalWhite = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    color: AppColors.white,
  fontFamily: AppTextStyle.primaryFont);
  static final normalWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumWhite = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final mediumWhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final smallWhite = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final smallWhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallWhite = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    color: Colors.white,
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    color: Colors.white,
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xxSmallWhiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(
        AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

//------------------------  yellow
  static final smallYellowBold = TextStyle(
    color: AppColors.deepYellow,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);


//------------------------ DeepGray

  static final mediumGraySemiBold = TextStyle(
      color: AppColors.gray_1,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static final largeGraySemiBold = TextStyle(
      color: AppColors.gray_1,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static final smallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final smallBoldGray = TextStyle(
      color: AppColors.deepGray,
      fontWeight: FontWeight.bold,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
      fontFamily: AppTextStyle.primaryFont);

  static final xSmallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final xxSmallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);


  static final mediumDeepGrayBold = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  fontFamily: AppTextStyle.primaryFont);

//  ---------------------- black
//  ---------------------- gray start
  static final normalGray = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      color: AppColors.gray,
      fontFamily: AppTextStyle.primaryFont);

  static final normalLighterGray = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      color: AppColors.gray343,
      fontFamily: AppTextStyle.primaryFont);

  static final largeLighterGray = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.mediumX_large_font_size),
      color: AppColors.gray343,
      fontFamily: AppTextStyle.primaryFont);
//  ---------------------- gray end

  //  ---------------------- black start

  static final largeBlackBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumXLargeBlackBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.mediumX_large_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);

  static final halfXLargeBlackBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.halfX_large_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);

  static final x_LargeBlackBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_large_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);

  static final largeBlack = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.black,
  fontFamily: AppTextStyle.primaryFont);

  static final xxLargeBlackBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_large_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);
//  ---------------------- black end

  static final largeGreen = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final largeGreenBold = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final largeOrange = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final largeOrangeBold = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final largeBlackSemiBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.halfX_large_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static final normalBlackSemiBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyle.primaryFont);

  static final normalBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final normalBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final normalGreen = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);

  //  ---------------------- cyan start

  static final normalCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final largeCyanBold = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xxLargeCyanBold = TextStyle(
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_large_font_size),
      color: AppColors.cyan,
      fontWeight: FontWeight.bold,
      fontFamily: AppTextStyle.primaryFont);
//  ---------------------- cyan end

  static final normalGreenBold = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final normalOrange = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final mediumBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final mediumBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final smallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final smallBlackThin = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.w500,
  fontFamily: AppTextStyle.primaryFont);
  static final smallBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final smallGreenBold = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final smallOrangeBold = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallBlackUnderLine = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    decoration: TextDecoration.underline,
  fontFamily: AppTextStyle.primaryFont);

  static final xxSmallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);


//------------------ red

  static final normalRedBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    color: AppColors.red,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final mediumRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final smallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final smallRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final xxSmallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  ////////////////////// green
  static final smallGreen = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final xSmallGreen = TextStyle(
    color: AppColors.primary,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  ///////////////////////// Orange
  static final smallOrange = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final xSmallOrange = TextStyle(
      color: AppColors.orange,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);



  static final errorStyle = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);


  ////////////////////// blue


  static final smallBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final smallBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final normalBlue = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final normalBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final mediumBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  fontFamily: AppTextStyle.primaryFont);
  static final largeBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final largeBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
  fontFamily: AppTextStyle.primaryFont);
  /////////////////////////////////// cyan

  static final smallCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final xSmallCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final smallCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final normalCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);

  static final mediumCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.bold,
  fontFamily: AppTextStyle.primaryFont);
  static final mediumCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  fontFamily: AppTextStyle.primaryFont);

  static final Shadow appShadow =  Shadow(color: AppColors.black.withOpacity(0.35), blurRadius: 6 , offset: Offset(0, 6));
}
