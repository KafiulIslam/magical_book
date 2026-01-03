import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/bangla_category.dart';
import '../../features/bangla/models/bangla_chora_model.dart';
import '../../features/english/model/rhymes_model.dart';
import 'asset_path.dart';

/// Contains all constant values and lists related to English feature
class EnglishConstants {

  /// List of English learning categories
  static const List<BanglaCategory> englishCategories = [
    BanglaCategory(
      title: 'Alphabet',
      subtitle: 'English Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
      route: Routes.englishAlphabet,
    ),
    BanglaCategory(
      title: 'Rhymes',
      subtitle: 'English Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
      route: Routes.englishRhymes,
    ),
    BanglaCategory(
      title: 'Fruits',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
      route: Routes.englishFruits,
    ),
    BanglaCategory(
      title: 'Flowers',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
      route: Routes.englishFlowers,
    ),
    BanglaCategory(
      title: 'Figures',
      subtitle: 'Figures & Shapes',
      icon: Icons.looks,
      color: AppColors.info,
      route: Routes.englishFigures,
    ),
    BanglaCategory(
      title: 'Body Parts',
      subtitle: 'Body Parts',
      icon: Icons.accessibility,
      color: AppColors.primary,
      route: Routes.englishBodyParts,
    ),
    BanglaCategory(
      title: 'Days',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
      route: Routes.englishDays,
    ),
    BanglaCategory(
      title: 'Months',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.action,
      route: Routes.englishMonths,
    ),
    BanglaCategory(
      title: 'Animals',
      subtitle: 'Animal Names',
      icon: Icons.pets,
      color: AppColors.action,
      route: Routes.englishAnimals,
    ),
    BanglaCategory(
      title: 'Birds',
      subtitle: 'Bird Names',
      icon: Icons.forest,
      color: AppColors.action,
      route: Routes.englishBirds,
    ),
  ];

  /// List of English alphabet (A to Z)
  static const List<String> englishAlphabet = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  // English Rhymes
  static List<RhymesModel> englishRhymes = [
    const RhymesModel(
        id: 1,
        title: 'আতা গাছে তোতা পাখী',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const RhymesModel(
        id: 2,
        title: 'আয় ছেলেরা আয় মেয়েরা',
        image: AssetPath.ayCheleraAyMeyera,
        audio: 'audio'),
    const RhymesModel(
        id: 1,
        title: 'হাট্টিমাটিম টিম',
        image: AssetPath.hattiMatim,
        audio: 'audio'),

  ];

}
