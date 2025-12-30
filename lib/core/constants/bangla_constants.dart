import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/bangla/models/bangla_chora_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/bangla_category.dart';
import 'asset_path.dart';

/// Contains all constant values and lists related to Bangla feature
class BanglaConstants {
  /// List of Bangla learning categories
  static const List<BanglaCategory> categories = [
    BanglaCategory(
      title: 'বর্ণমালা',
      subtitle: 'Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
      route: Routes.bornoMala,
    ),
    BanglaCategory(
      title: 'ছড়া',
      subtitle: 'Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
      route: Routes.chora,
    ),
    BanglaCategory(
      title: 'ফলের নাম',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
      route: Routes.chora,
    ),
    BanglaCategory(
      title: 'ফুলের নাম',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
      route: Routes.chora,
    ),
    BanglaCategory(
      title: 'রিতুর নাম',
      subtitle: 'Season Names',
      icon: Icons.wb_sunny,
      color: AppColors.info,
      route: Routes.chora,
    ),
    BanglaCategory(
      title: 'মাসের নাম',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.primary,
      route: Routes.chora,
    ),
    BanglaCategory(
      title: 'দিনের নাম',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
      route: Routes.chora,
    ),
  ];

  // bangla borno mala
  /// List of Bangla shoroborno (Vowels)
  static const List<String> banglaShorobornos = <String>[
    'অ',
    'আ',
    'ই',
    'ঈ',
    'উ',
    'ঊ',
    'ঋ',
    'এ',
    'ঐ',
    'ও',
    'ঔ',
  ];

  /// List of Bangla byanjonborno (Consonants)
  static const List<String> banglaByanjonbornos = <String>[
    'ক',
    'খ',
    'গ',
    'ঘ',
    'ঙ',
    'চ',
    'ছ',
    'জ',
    'ঝ',
    'ঞ',
    'ট',
    'ঠ',
    'ড',
    'ঢ',
    'ণ',
    'ত',
    'থ',
    'দ',
    'ধ',
    'ন',
    'প',
    'ফ',
    'ব',
    'ভ',
    'ম',
    'য',
    'র',
    'ল',
    'শ',
    'ষ',
    'স',
    'হ',
    'ড়',
    'ঢ়',
    'য়',
    'ৎ',
    'ং',
    'ঃ',
    'ঁ',
  ];

  // bangla chora
  static List<BanglaChoraModel> banglaChora = [
    const BanglaChoraModel(
        id: 1,
        title: 'আতা গাছে তোতা পাখী',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 2,
        title: 'আয় ছেলেরা আয় মেয়েরা',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'হাট্টিমাটিম টিম',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'আম পাতা জোড়া জোড়া',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'বাক বাকুম পায়রা',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'ঐ দেখা যায় তালগাছ',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
  ];
}
