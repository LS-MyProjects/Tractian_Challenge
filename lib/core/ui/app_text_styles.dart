import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static const TextStyle filterTextActive = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle filterTextInactive = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle itemTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle itemSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.lightGray,
  );
}
