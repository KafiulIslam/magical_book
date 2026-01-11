import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';

// Contains all constant values and lists related to Math feature
class MathConstants {
  // List of Math learning categories
  static const List<Category> mathCategories = [
    Category(
      title: 'বাংলা সংখ্যা',
      subtitle: 'Bangla Numbers',
      icon: Icons.looks_one,
      color: AppColors.primary,
      route: Routes.banglaNumbers,
    ),
    Category(
      title: 'ইংরেজি সংখ্যা',
      subtitle: 'English Numbers',
      icon: Icons.looks_one,
      color: AppColors.action,
      route: Routes.englishNumbers,
    ),
    Category(
      title: 'নামতা',
      subtitle: 'Multiplication',
      icon: Icons.table_chart,
      color: AppColors.success,
      route: Routes.multiplicationTable,
    ),
    Category(
      title: 'ক্যালকুলেটর',
      subtitle: 'Calculator',
      icon: Icons.calculate,
      color: AppColors.reward,
      route: Routes.calculator,
    ),
  ];

  // Bangla Numbers (০-৯)
  static const List<String> banglaNumbers = <String>[
    '০',
    '১',
    '২',
    '৩',
    '৪',
    '৫',
    '৬',
    '৭',
    '৮',
    '৯',
    '১০'
  ];

}
