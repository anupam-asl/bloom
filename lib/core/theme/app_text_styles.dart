import 'package:flutter/material.dart';
import 'app_colors.dart';

class FontFamily {
  static const inter = 'Inter';
}

class FontSizes {
  static const double large = 24.0;
  static const double medium = 20.0;
  static const double body = 16.0;
  static const double caption = 12.0;
}

class FontWeights {
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight regular = FontWeight.w400;
}

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSizes.large,
    fontWeight: FontWeights.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSizes.medium,
    fontWeight: FontWeights.semiBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSizes.body,
    fontWeight: FontWeights.regular,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSizes.caption,
    fontWeight: FontWeights.regular,
    color: AppColors.textSecondary,
  );
}
