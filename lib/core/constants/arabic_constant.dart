import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';
import '../../features/math/model/multiplication_model.dart';
import 'asset_path.dart';

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

  // Surah List
  static List<MultiplicationModel> surahList = [
    MultiplicationModel(
        id: 1,
        title: '১',
        subTitle: 'সূরাতুল ফাতিহা',
        image: AssetPath.fatiha),
    MultiplicationModel(
        id: 2,
        title: '২',
        subTitle: 'সূরাতুল আল-আসর',
        image: AssetPath.asar),
    MultiplicationModel(
        id: 3,
        title: '৩',
        subTitle: 'সূরাতুল ফালাক',
        image: AssetPath.falaq),
    MultiplicationModel(
        id: 4, title: '৪', subTitle: 'সূরাতুল ফিল', image: AssetPath.fil),
    MultiplicationModel(
        id: 5,
        title: '৫',
        subTitle: 'সূরাতুল ইখলাস',
        image: AssetPath.ikhlas),
    MultiplicationModel(
        id: 6,
        title: '৬',
        subTitle: 'সূরাতুল কাউসার',
        image: AssetPath.kawsar),
    MultiplicationModel(
        id: 7,
        title: '৭',
        subTitle: 'সূরাতুল কুরাইশ',
        image: AssetPath.kurais),
    MultiplicationModel(
        id: 8, title: '৮', subTitle: 'সূরাতুল নাস', image: AssetPath.nas),
    MultiplicationModel(
        id: 9, title: '৯', subTitle: 'সূরাতুল নাসর', image: AssetPath.nasr),
  ];

}
