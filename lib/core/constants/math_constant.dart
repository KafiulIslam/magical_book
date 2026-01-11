import 'package:flutter/material.dart';
import 'package:magical_book/core/constants/asset_path.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/math/model/multiplication_model.dart';
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

  // Bangla Numbers (০-১০)
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

  // English Numbers (0-10)
  static const List<String> englishNumbers = <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  // multiplication list
  static List<MultiplicationModel> multiplicationList = [
    MultiplicationModel(
        id: 1,
        title: '১',
        subTitle: 'একের ঘরের নামতা',
        image: AssetPath.multiOne),
    MultiplicationModel(
        id: 2,
        title: '২',
        subTitle: 'দুইয়ের ঘরের নামতা',
        image: AssetPath.multiTwo),
    MultiplicationModel(
        id: 3,
        title: '৩',
        subTitle: 'তিনের ঘরের নামতা',
        image: AssetPath.multiThree),
    MultiplicationModel(
        id: 4,
        title: '৪',
        subTitle: 'চারের ঘরের নামতা',
        image: AssetPath.multiFive),
    MultiplicationModel(
        id: 5,
        title: '৫',
        subTitle: 'পাঁচের ঘরের নামতা',
        image: AssetPath.multiFive),
    MultiplicationModel(
        id: 6,
        title: '৬',
        subTitle: 'ছয়ের ঘরের নামতা',
        image: AssetPath.multiSix),
    MultiplicationModel(
        id: 7,
        title: '৭',
        subTitle: 'সাতের ঘরের নামতা',
        image: AssetPath.multiSeven),
    MultiplicationModel(
        id: 8,
        title: '৮',
        subTitle: 'আটের ঘরের নামতা',
        image: AssetPath.multiEight),
    MultiplicationModel(
        id: 9,
        title: '৯',
        subTitle: 'নয়ের ঘরের নামতা',
        image: AssetPath.multiNine),
    MultiplicationModel(
        id: 10,
        title: '১০',
        subTitle: 'দশের ঘরের নামতা',
        image: AssetPath.multiTen),
  ];

}
