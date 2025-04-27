import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_attendance/core/theming/colors.dart';

ThemeData lightMode() => ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: ColorsManager.primaryColor,
  appBarTheme: AppBarTheme(
    surfaceTintColor: ColorsManager.primaryColor,
    backgroundColor: ColorsManager.primaryColor,
    elevation: 0,
    actionsIconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: GoogleFonts.cairo(fontSize: 20.sp, color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarBrightness: Brightness.dark,
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    // ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: BorderSide(
    //     color: ColorsManager.primaryColor,
    //     width: 2,
    //   ), // لون الحقل عند التركيز
    // ),
    // contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    // hintStyle: GoogleFonts.cairo(fontSize: 14.sp),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   backgroundColor: Colors.white,
  //   selectedItemColor: ColorsManager.primaryColor,
  //   unselectedItemColor: Colors.grey,
  //   showUnselectedLabels: true,
  //   type: BottomNavigationBarType.fixed,
  // ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color:
        ColorsManager.primaryColor, // إضافة لون الـ CircularProgressIndicator
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ColorsManager.primaryColor, // لون المؤشر الوامض
    selectionColor: ColorsManager.primaryColor.withOpacity(
      0.1,
    ), // لون النص المحدد
    selectionHandleColor:
        ColorsManager.primaryColor, //  لون النقطة الكبيرة تحت المؤشر
  ),
  // fontFamily: 'Cairo', // أو أي خط تريده
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.cairo(
      fontSize: 22.sp,
      color: ColorsManager.primaryColor,
    ), // النصوص الكبيرة
    bodyMedium: GoogleFonts.cairo(
      fontSize: 16.sp,
      color: ColorsManager.primaryColor,
    ), // النصوص العادية
    bodySmall: GoogleFonts.cairo(
      fontSize: 14.sp,
      color: ColorsManager.primaryColor,
    ),
    headlineLarge: GoogleFonts.cairo(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.primaryColor,
    ),
    headlineMedium: GoogleFonts.cairo(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.primaryColor,
    ),
    headlineSmall: GoogleFonts.cairo(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.primaryColor,
    ),
  ),
);
