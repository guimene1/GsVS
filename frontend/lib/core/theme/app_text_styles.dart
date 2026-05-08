import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  //logo
  static const TextStyle logoTitle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
    letterSpacing: -1,
  );

  static const TextStyle logoSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  //headings
  static const TextStyle headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  //body
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  //label
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  //input
  static const TextStyle inputText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  //button - primary
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  //link
  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.link,
    decoration: TextDecoration.none,
  );
}
