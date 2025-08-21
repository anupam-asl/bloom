import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.primary,
      cardColor: AppColors.primary, // background for all Cards

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary,
        selectedColor: AppColors.selectedColorFilter,
        disabledColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 14.sp,        // responsive font size
          fontWeight: FontWeight.w500, // medium weight
          color: Colors.black,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
      ),


      textTheme: TextTheme(
        // 1. Title / Headline
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 24.sp,             // ✅ responsive font
          height: (28 / 24),         // ✅ responsive line-height
          letterSpacing: 0,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400, // SemiBold
          fontSize: 24.sp,             // ✅ responsive font
          height: (28 / 24),         // ✅ responsive line-height
          letterSpacing: 0,
          color: Colors.black,
        ),

        // 2. Subtitle
        titleMedium: TextStyle(
          fontWeight: FontWeight.w400, // Regular
          fontSize: 16.sp,
          height: (24 / 16),
          letterSpacing: 0,
          color: Colors.black87,
        ),

        // 3. Medium
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400, // Regular
          fontSize: 14.sp,
          height: 1.0, // keep 100%
          letterSpacing: 0,
          color: Colors.black87,
        ),

        // 4. Small
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400, // Regular
          fontSize: 12.sp,
          height: (16 / 12),
          letterSpacing: 0,
          color: Colors.black54,
        ),
      ),
    );
  }


  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
    );
  }
}
