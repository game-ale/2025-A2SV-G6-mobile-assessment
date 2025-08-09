import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {

   // AppBar title style
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
  );

  // Chat styles
  static const TextStyle chatMessageDark = TextStyle(
    fontSize: 16,
    color: AppColors.chatMessageDark,
  );

  static const TextStyle chatMessageWhite = TextStyle(
    fontSize: 16,
    color: AppColors.chatMessageWhite,
  );

  static const TextStyle chatTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle chatSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.lightGray,
  );

  static const TextStyle timestamp = TextStyle(
    fontSize: 12,
    color: AppColors.lightGray,
  );

  // Input hint text
  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    color: AppColors.lightGray,
  );

  // Small text style
  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    color: AppColors.lightGray,
  );

  // Unread badge
  static const TextStyle unreadBadge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );
  static const heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const errorText = TextStyle(
    fontSize: 14,
    color: AppColors.error,
  );
}
