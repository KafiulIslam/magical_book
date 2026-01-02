import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/bangla/models/bangla_chora_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/bangla_category.dart';
import '../../features/bangla/models/bangla_fol_model.dart';
import '../../features/bangla/models/bangla_ful_model.dart';
import '../../features/bangla/models/bangla_mas_model.dart';
import '../../features/bangla/models/bangla_din_model.dart';
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
      route: Routes.folerNam,
    ),
    BanglaCategory(
      title: 'ফুলের নাম',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
      route: Routes.fulerNam,
    ),
    BanglaCategory(
      title: 'রিতুর নাম',
      subtitle: 'Season Names',
      icon: Icons.wb_sunny,
      color: AppColors.info,
      route: Routes.riturNam,
    ),
    BanglaCategory(
      title: 'মাসের নাম',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.primary,
      route: Routes.maserNam,
    ),
    BanglaCategory(
      title: 'দিনের নাম',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
      route: Routes.dinerNam,
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
        image: AssetPath.ayCheleraAyMeyera,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'হাট্টিমাটিম টিম',
        image: AssetPath.hattiMatim,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'আম পাতা জোড়া জোড়া',
        image: AssetPath.amPataJoraJora,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'বাক বাকুম পায়রা',
        image: AssetPath.bakBakumPayra,
        audio: 'audio'),
    const BanglaChoraModel(
        id: 1,
        title: 'ঐ দেখা যায় তালগাছ',
        image: AssetPath.talGach,
        audio: 'audio'),
  ];

  // bangla foler nam
  static List<BanglaFolModel> banglaFolerNam = [
    BanglaFolModel(id: 1, name: 'আম', image: AssetPath.mango, audio: 'audio'),
    BanglaFolModel(id: 2, name: 'কলা', image: AssetPath.banana, audio: 'audio'),
    BanglaFolModel(id: 3, name: 'আপেল', image: AssetPath.apple, audio: 'audio'),
    BanglaFolModel(
        id: 4, name: 'কমলা', image: AssetPath.orange, audio: 'audio'),
    BanglaFolModel(
        id: 5, name: 'তরমুজ', image: AssetPath.waterMelon, audio: 'audio'),
    BanglaFolModel(
        id: 6, name: 'আনারস', image: AssetPath.mango, audio: 'audio'),
    BanglaFolModel(
        id: 7, name: 'আঙ্গুর', image: AssetPath.grape, audio: 'audio'),
    BanglaFolModel(
        id: 8, name: 'কাঁঠাল', image: AssetPath.jackFruit, audio: 'audio'),
  ];

  // bangla foler nam
  static List<BanglaFulModel> banglaFulerNam = [
    BanglaFulModel(
        id: 1, name: 'শাপলা', image: AssetPath.shapla, audio: 'audio'),
    BanglaFulModel(
        id: 2, name: 'গোলাপ', image: AssetPath.golap, audio: 'audio'),
    BanglaFulModel(id: 3, name: 'জবা', image: AssetPath.joba, audio: 'audio'),
    BanglaFulModel(
        id: 4, name: 'গাঁদা', image: AssetPath.gadha, audio: 'audio'),
    BanglaFulModel(
        id: 5, name: 'সূর্যমুখী', image: AssetPath.surjo, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    BanglaFulModel(
        id: 7, name: 'শিউলি', image: AssetPath.shuly, audio: 'audio'),
    BanglaFulModel(id: 8, name: 'বকুল', image: AssetPath.bokul, audio: 'audio'),
    BanglaFulModel(
        id: 9, name: 'কৃষ্ণচুড়া', image: AssetPath.krisnochura, audio: 'audio'),
  ];

  // bangla foler nam
  static List<BanglaFulModel> banglaRitu = [
    BanglaFulModel(
        id: 1, name: 'গ্রীষ্মকাল', image: AssetPath.summer, audio: 'audio'),
    BanglaFulModel(
        id: 2, name: 'বর্ষাকাল', image: AssetPath.rainy, audio: 'audio'),
    BanglaFulModel(
        id: 3, name: 'শরৎকাল', image: AssetPath.atumn, audio: 'audio'),
    BanglaFulModel(
        id: 4, name: 'হেমন্তকাল', image: AssetPath.hemonto, audio: 'audio'),
    BanglaFulModel(
        id: 5, name: 'শীতকাল', image: AssetPath.winter, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    BanglaFulModel(
        id: 7, name: 'বসন্তকাল', image: AssetPath.spring, audio: 'audio'),
  ];

  // bangla maser nam (Month Names)
  static const List<BanglaMasModel> banglaMas = [
    BanglaMasModel(id: 1, name: 'বৈশাখ', audio: 'audio'),
    BanglaMasModel(id: 2, name: 'জৈষ্ঠ্য', audio: 'audio'),
    BanglaMasModel(id: 3, name: 'আষাঢ়', audio: 'audio'),
    BanglaMasModel(id: 4, name: 'শ্রাবণ', audio: 'audio'),
    BanglaMasModel(id: 5, name: 'ভাদ্র', audio: 'audio'),
    BanglaMasModel(id: 6, name: 'আশ্বিন', audio: 'audio'),
    BanglaMasModel(id: 7, name: 'কার্তিক', audio: 'audio'),
    BanglaMasModel(id: 8, name: 'অগ্রহায়ণ', audio: 'audio'),
    BanglaMasModel(id: 9, name: 'পৌষ', audio: 'audio'),
    BanglaMasModel(id: 10, name: 'মাঘ', audio: 'audio'),
    BanglaMasModel(id: 11, name: 'ফাল্গুন', audio: 'audio'),
    BanglaMasModel(id: 12, name: 'চৈত্র', audio: 'audio'),
  ];

  // bangla diner nam (Day Names)
  static const List<BanglaDinModel> banglaDin = [
    BanglaDinModel(id: 1, name: 'রবিবার', audio: 'audio'),
    BanglaDinModel(id: 2, name: 'সোমবার', audio: 'audio'),
    BanglaDinModel(id: 3, name: 'মঙ্গলবার', audio: 'audio'),
    BanglaDinModel(id: 4, name: 'বুধবার', audio: 'audio'),
    BanglaDinModel(id: 5, name: 'বৃহস্পতিবার', audio: 'audio'),
    BanglaDinModel(id: 6, name: 'শুক্রবার', audio: 'audio'),
    BanglaDinModel(id: 7, name: 'শনিবার', audio: 'audio'),
  ];
}
