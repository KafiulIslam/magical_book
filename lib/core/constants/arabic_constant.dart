import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';

// Contains all constant values and lists related to Arabic feature
class ArabicConstants {

  // List of Arabic learning categories
  static const List<Category> arabicCategories = [
    Category(
      title: 'আরবি বর্নমালা',
      subtitle: 'Arabic Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
      route: Routes.arabicAlphabet,
    ),
    Category(
      title: 'সূরা',
      subtitle: 'Surah',
      icon: Icons.menu_book,
      color: AppColors.action,
      route: Routes.arabicSurah,
    ),
    Category(
      title: 'ইসলামিক গজল',
      subtitle: 'Islamic Ghazal',
      icon: Icons.music_note,
      color: AppColors.success,
      route: Routes.arabicGhazal,
    ),
    Category(
      title: 'ইসলামিক ইতিহাস',
      subtitle: 'Islamic History',
      icon: Icons.history,
      color: AppColors.reward,
      route: Routes.arabicHistory,
    ),
  ];

  // List of Arabic alphabet (ا to ي)
  static const List<String> arabicAlphabet = <String>[
    'ا', // Alif
    'ب', // Ba
    'ت', // Ta
    'ث', // Tha
    'ج', // Jim
    'ح', // Ha
    'خ', // Kha
    'د', // Dal
    'ذ', // Dhal
    'ر', // Ra
    'ز', // Zay
    'س', // Sin
    'ش', // Shin
    'ص', // Sad
    'ض', // Dad
    'ط', // Ta
    'ظ', // Za
    'ع', // Ayn
    'غ', // Ghayn
    'ف', // Fa
    'ق', // Qaf
    'ك', // Kaf
    'ل', // Lam
    'م', // Mim
    'ن', // Nun
    'ه', // Ha
    'و', // Waw
    'ي', // Ya
  ];

}
