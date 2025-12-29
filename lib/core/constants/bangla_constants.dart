import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/bangla_category.dart';

/// Contains all constant values and lists related to Bangla feature
class BanglaConstants {
  /// List of Bangla learning categories
  static const List<BanglaCategory> categories = [
    BanglaCategory(
      title: 'বর্ণমালা',
      subtitle: 'Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
    ),
    BanglaCategory(
      title: 'ছড়া',
      subtitle: 'Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
    ),
    BanglaCategory(
      title: 'ফলের নাম',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
    ),
    BanglaCategory(
      title: 'ফুলের নাম',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
    ),
    BanglaCategory(
      title: 'রিতুর নাম',
      subtitle: 'Season Names',
      icon: Icons.wb_sunny,
      color: AppColors.info,
    ),
    BanglaCategory(
      title: 'মাসের নাম',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.primary,
    ),
    BanglaCategory(
      title: 'দিনের নাম',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
    ),
  ];

  // Add more Bangla-related constants and lists here as needed
  // Example:
  // static const List<String> alphabetList = [...];
  // static const List<String> rhymesList = [...];
  // static const String appTitle = 'বাংলা শিখুন';
}
