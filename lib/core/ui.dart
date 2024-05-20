import 'package:flutter/material.dart';

class AppColors {
  static Color appColor = const Color(0xfffF47906);
  static Color appBgColorlite = const Color(0xffffffff);
  static Color appBgColordart = const Color(0xff10100b);
  static Color textLight = const Color(0xff10192D);
  static Color text1Light = const Color(0xff8E9BAE);
  static Color textDark = const Color(0xffF8FAFC);
  static Color text1Dark = const Color(0xffE2E8F0);
  static Color greyDark = const Color(0xff979491);
  static Color greyLight = const Color(0xffE2E8F0);
  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xff0F172A);
  static Color borderColor = const Color(0xffEAEAEA);
  static Color darkBorderColor = const Color(0xff24211F);
  static Color darkBgColor = const Color(0xff110D0A);
  static Color darkContainer = const Color(0xff1B1816);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dividerColor: Colors.transparent,
    brightness: Brightness.light,
    fontFamily: FontFamilyy.regular,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(12)),
      fixedSize: const Size.fromHeight(50),
    )),
   cardColor: AppColors.white,
    dividerTheme: DividerThemeData(color: AppColors.borderColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            elevation: 0,
            backgroundColor: AppColors.appColor,
            fixedSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: AppColors.greyLight),
              borderRadius: BorderRadius.circular(12),
            )

        )),
    textTheme: TextTheme(

        //this is headLine TextStyles for lite Mode
        headlineLarge: TextStyles.heading1,
        headlineMedium: TextStyles.heading2,
        headlineSmall: TextStyles.heading3,

        //this is Body TextStyles for lite Mode
        bodyLarge: TextStyles.body1,
        bodyMedium: TextStyles.body2,
        bodySmall: TextStyles.body3,

        //this is title TextStyles for lite Mode
        titleMedium: TextStyles.title1,
        titleSmall: TextStyles.title2,

        //this is Button TextStyles for lite Mode
        labelMedium: TextStyles.buttonTextStyle),
    scaffoldBackgroundColor: AppColors.appBgColorlite,
    indicatorColor: AppColors.black,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.appBgColordart,
      iconTheme: IconThemeData(color: AppColors.textLight),

    ),
  );

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dividerColor: Colors.transparent,
    fontFamily: FontFamilyy.regular,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.darkBgColor),
    cardColor: AppColors.darkContainer,
    dividerTheme: DividerThemeData(color: AppColors.darkBorderColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(12)),
      fixedSize: const Size.fromHeight(48),
    )),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.appColor,
            fixedSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ))),
    indicatorColor: AppColors.white,
    textTheme: TextTheme(
      //this is headLine TextStyles for Dark Mode
      headlineLarge: TextStyles.heading1.copyWith(color: AppColors.textDark),
      headlineMedium: TextStyles.heading2.copyWith(color: AppColors.textDark),
      headlineSmall: TextStyles.heading3.copyWith(color: AppColors.textDark),

      //this is Body TextStyles for Dark Mode
      bodyLarge: TextStyles.body1.copyWith(color: AppColors.text1Dark),
      bodyMedium: TextStyles.body2.copyWith(color: AppColors.text1Dark),
      bodySmall: TextStyles.body3.copyWith(color: AppColors.text1Dark),

      //this is title TextStyles for Dark Mode
      titleMedium: TextStyles.title1.copyWith(color: AppColors.textDark),
      titleSmall: TextStyles.title2.copyWith(color: AppColors.textDark),

      //this is Button TextStyles for Dark Mode
      labelMedium: TextStyles.buttonTextStyle,
    ),
    scaffoldBackgroundColor: AppColors.appBgColordart,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.appBgColordart,
      iconTheme: IconThemeData(color: AppColors.textLight),
    ),
  );
}

class TextStyles {
  static TextStyle heading1 = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.textLight,
      fontSize: 70,
      fontFamily: FontFamilyy.bold);

  static TextStyle heading2 = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.textLight,
      fontSize: 32,
      fontFamily: FontFamilyy.bold);

  static TextStyle heading3 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: AppColors.textLight,
      fontFamily: FontFamilyy.bold);

  static TextStyle body1 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: AppColors.textLight,
      fontFamily: FontFamilyy.medium);

  static TextStyle body2 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: AppColors.textLight,
      fontFamily: FontFamilyy.medium);

  static TextStyle body3 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.textLight,
      fontFamily: FontFamilyy.medium);

  static TextStyle title1 = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: AppColors.borderColor,
      fontFamily: FontFamilyy.regular);

  static TextStyle title2 = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 10,
      color: AppColors.borderColor,
      fontFamily: FontFamilyy.regular);

  static TextStyle buttonTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: AppColors.textLight,
      fontFamily: FontFamilyy.medium
  );
}

class FontFamilyy {
  static const String regular = "Satoshi-Regular";
  static const String bold = "Satoshi-Bold";
  static const String medium = "Satoshi-Medium";
  static const String black = "Satoshi-Black";
}
