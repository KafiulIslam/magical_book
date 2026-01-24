import 'package:flutter/material.dart';
import 'package:magical_book/core/constants/audio_path.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/bangla/models/common_content_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';
import '../../features/bangla/models/day_month_model.dart';
import 'asset_path.dart';

/// Contains all constant values and lists related to Bangla feature
class BanglaConstants {
  // List of Bangla learning categories
  static const List<Category> categories = [
    Category(
      title: 'বর্ণমালা',
      subtitle: 'Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
      route: Routes.bornoMala,
    ),
    Category(
      title: 'ছড়া',
      subtitle: 'Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
      route: Routes.chora,
    ),
    Category(
      title: 'ফলের নাম',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
      route: Routes.folerNam,
    ),
    Category(
      title: 'ফুলের নাম',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
      route: Routes.fulerNam,
    ),
    Category(
      title: 'রিতুর নাম',
      subtitle: 'Season Names',
      icon: Icons.wb_sunny,
      color: AppColors.info,
      route: Routes.riturNam,
    ),
    Category(
      title: 'মাসের নাম',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.primary,
      route: Routes.maserNam,
    ),
    Category(
      title: 'দিনের নাম',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
      route: Routes.dinerNam,
    ),
  ];

  // bangla borno mala
  // List of Bangla shoroborno (Vowels)

  static const List<CommonContentModel> banglaShorobornos = <CommonContentModel>[
    CommonContentModel(id: 1, title: 'অ', image: '', audio: AudioPath.shoroO),
    CommonContentModel(id: 2, title: 'আ', image: '', audio: AudioPath.shoroA),
    CommonContentModel(id: 3, title: 'ই', image: '', audio: AudioPath.roshE),
    CommonContentModel(id: 4, title: 'ঈ', image: '', audio: AudioPath.dirE),
    CommonContentModel(id: 5, title: 'উ', image: '', audio: AudioPath.roshU),
    CommonContentModel(id: 6, title: 'ঊ', image: '', audio: AudioPath.dirU),
    CommonContentModel(id: 7, title: 'ঋ', image: '', audio: AudioPath.ree),
    CommonContentModel(id: 8, title: 'এ', image: '', audio: AudioPath.aaa),
    CommonContentModel(id: 9, title: 'ঐ', image: '', audio: AudioPath.oi),
    CommonContentModel(id: 10, title: 'ও', image: '', audio: AudioPath.ooo),
    CommonContentModel(id: 11, title: 'ঔ', image: '', audio: AudioPath.oi),
  ];

  // static const List<String> banglaShorobornos = <String>[
  //   'অ',
  //   'আ',
  //   'ই',
  //   'ঈ',
  //   'উ',
  //   'ঊ',
  //   'ঋ',
  //   'এ',
  //   'ঐ',
  //   'ও',
  //   'ঔ',
  // ];


  // List of Bangla byanjonborno (Consonants)
  static const List<CommonContentModel> banglaByanjonbornos = <CommonContentModel>[
    CommonContentModel(id: 1, title: 'ক', image: '', audio: 'audio'),
    CommonContentModel(id: 2, title: 'খ', image: '', audio: 'audio'),
    CommonContentModel(id: 3, title: 'গ', image: '', audio: 'audio'),
    CommonContentModel(id: 4, title: 'ঘ', image: '', audio: 'audio'),
    CommonContentModel(id: 5, title: 'ঙ', image: '', audio: 'audio'),
    CommonContentModel(id: 6, title: 'চ', image: '', audio: 'audio'),
    CommonContentModel(id: 7, title: 'ছ', image: '', audio: 'audio'),
    CommonContentModel(id: 8, title: 'জ', image: '', audio: 'audio'),
    CommonContentModel(id: 9, title: 'ঝ', image: '', audio: 'audio'),
    CommonContentModel(id: 10, title: 'ঞ', image: '', audio: 'audio'),
    CommonContentModel(id: 11, title: 'ট', image: '', audio: 'audio'),
    CommonContentModel(id: 1, title: 'ঠ', image: '', audio: 'audio'),
    CommonContentModel(id: 2, title: 'ড', image: '', audio: 'audio'),
    CommonContentModel(id: 3, title: 'ঢ', image: '', audio: 'audio'),
    CommonContentModel(id: 4, title: 'ণ', image: '', audio: 'audio'),
    CommonContentModel(id: 5, title: 'ত', image: '', audio: 'audio'),
    CommonContentModel(id: 6, title: 'থ', image: '', audio: 'audio'),
    CommonContentModel(id: 7, title: 'দ', image: '', audio: 'audio'),
    CommonContentModel(id: 8, title: 'ধ', image: '', audio: 'audio'),
    CommonContentModel(id: 9, title: 'ন', image: '', audio: 'audio'),
    CommonContentModel(id: 10, title: 'প', image: '', audio: 'audio'),
    CommonContentModel(id: 11, title: 'ফ', image: '', audio: 'audio'),
    CommonContentModel(id: 1, title: 'ব', image: '', audio: 'audio'),
    CommonContentModel(id: 2, title: 'ভ', image: '', audio: 'audio'),
    CommonContentModel(id: 3, title: 'ম', image: '', audio: 'audio'),
    CommonContentModel(id: 4, title: 'য', image: '', audio: 'audio'),
    CommonContentModel(id: 5, title: 'র', image: '', audio: 'audio'),
    CommonContentModel(id: 6, title: 'ল', image: '', audio: 'audio'),
    CommonContentModel(id: 7, title: 'শ', image: '', audio: 'audio'),
    CommonContentModel(id: 8, title: 'ষ', image: '', audio: 'audio'),
    CommonContentModel(id: 9, title: 'স', image: '', audio: 'audio'),
    CommonContentModel(id: 10, title: 'হ', image: '', audio: 'audio'),
    CommonContentModel(id: 11, title: 'ড়', image: '', audio: 'audio'),
    CommonContentModel(id: 1, title: 'ঢ়', image: '', audio: 'audio'),
    CommonContentModel(id: 2, title: 'য়', image: '', audio: 'audio'),
    CommonContentModel(id: 3, title: 'ৎ', image: '', audio: 'audio'),
    CommonContentModel(id: 4, title: 'ং', image: '', audio: 'audio'),
    CommonContentModel(id: 5, title: 'ঃ', image: '', audio: 'audio'),
    CommonContentModel(id: 6, title: 'ঁ', image: '', audio: 'audio'),
  ];

  // static const List<String> banglaByanjonbornos = <String>[
  //   'ক',
  //   'খ',
  //   'গ',
  //   'ঘ',
  //   'ঙ',
  //   'চ',
  //   'ছ',
  //   'জ',
  //   'ঝ',
  //   'ঞ',
  //   'ট',
  //   'ঠ',
  //   'ড',
  //   'ঢ',
  //   'ণ',
  //   'ত',
  //   'থ',
  //   'দ',
  //   'ধ',
  //   'ন',
  //   'প',
  //   'ফ',
  //
  //
  //   'ব',
  //   'ভ',
  //   'ম',
  //   'য',
  //   'র',
  //   'ল',
  //   'শ',
  //   'ষ',
  //   'স',
  //   'হ',
  //   'ড়',
  //
  //   'ঢ়',
  //   'য়',
  //   'ৎ',
  //   'ং',
  //   'ঃ',
  //   'ঁ',
  // ];

  // bangla chora
  static List<CommonContentModel> banglaChora = [
    const CommonContentModel(
        id: 1,
        title: 'আতা গাছে তোতা পাখী',
        image: AssetPath.ataGacheTotaPakhi,
        audio: 'audio'),
    const CommonContentModel(
        id: 2,
        title: 'আয় ছেলেরা আয় মেয়েরা',
        image: AssetPath.ayCheleraAyMeyera,
        audio: 'audio'),
    const CommonContentModel(
        id: 1,
        title: 'হাট্টিমাটিম টিম',
        image: AssetPath.hattiMatim,
        audio: 'audio'),
    const CommonContentModel(
        id: 1,
        title: 'আম পাতা জোড়া জোড়া',
        image: AssetPath.amPataJoraJora,
        audio: 'audio'),
    const CommonContentModel(
        id: 1,
        title: 'বাক বাকুম পায়রা',
        image: AssetPath.bakBakumPayra,
        audio: 'audio'),
    const CommonContentModel(
        id: 1,
        title: 'ঐ দেখা যায় তালগাছ',
        image: AssetPath.talGach,
        audio: 'audio'),
  ];

  // bangla foler nam
  static const List<CommonContentModel> banglaFolerNam = [
    CommonContentModel(
        id: 1, title: 'আম', image: AssetPath.mango, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'আপেল', image: AssetPath.apple, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'কলা', image: AssetPath.banana, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'কমলা', image: AssetPath.orange, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'তরমুজ', image: AssetPath.waterMelon, audio: 'audio'),
    CommonContentModel(
        id: 6, title: 'আনারস', image: AssetPath.pineApple, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'আঙ্গুর', image: AssetPath.grape, audio: 'audio'),
    CommonContentModel(
        id: 8, title: 'কাঁঠাল', image: AssetPath.jackFruit, audio: 'audio'),
  ];

  // bangla fuler nam
  static const List<CommonContentModel> banglaFulerNam = [
    CommonContentModel(
        id: 1, title: 'শাপলা', image: AssetPath.shapla, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'গোলাপ', image: AssetPath.golap, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'জবা', image: AssetPath.joba, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'গাঁদা', image: AssetPath.gadha, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'সূর্যমুখী', image: AssetPath.surjo, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'শিউলি', image: AssetPath.shuly, audio: 'audio'),
    CommonContentModel(
        id: 8, title: 'বকুল', image: AssetPath.bokul, audio: 'audio'),
    CommonContentModel(
        id: 9,
        title: 'কৃষ্ণচুড়া',
        image: AssetPath.krisnochura,
        audio: 'audio'),
  ];

  // bangla ritur nam
  static const List<CommonContentModel> banglaRitu = [
    CommonContentModel(
        id: 1, title: 'গ্রীষ্মকাল', image: AssetPath.summer, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'বর্ষাকাল', image: AssetPath.rainy, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'শরৎকাল', image: AssetPath.atumn, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'হেমন্তকাল', image: AssetPath.hemonto, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'শীতকাল', image: AssetPath.winter, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'বসন্তকাল', image: AssetPath.spring, audio: 'audio'),
  ];

  // bangla maser nam (Month Names)
  static const List<DayMonthModel> banglaMas = [
    DayMonthModel(id: 1, name: 'বৈশাখ', audio: 'audio'),
    DayMonthModel(id: 2, name: 'জৈষ্ঠ্য', audio: 'audio'),
    DayMonthModel(id: 3, name: 'আষাঢ়', audio: 'audio'),
    DayMonthModel(id: 4, name: 'শ্রাবণ', audio: 'audio'),
    DayMonthModel(id: 5, name: 'ভাদ্র', audio: 'audio'),
    DayMonthModel(id: 6, name: 'আশ্বিন', audio: 'audio'),
    DayMonthModel(id: 7, name: 'কার্তিক', audio: 'audio'),
    DayMonthModel(id: 8, name: 'অগ্রহায়ণ', audio: 'audio'),
    DayMonthModel(id: 9, name: 'পৌষ', audio: 'audio'),
    DayMonthModel(id: 10, name: 'মাঘ', audio: 'audio'),
    DayMonthModel(id: 11, name: 'ফাল্গুন', audio: 'audio'),
    DayMonthModel(id: 12, name: 'চৈত্র', audio: 'audio'),
  ];

  // bangla diner nam (Day Names)
  static const List<DayMonthModel> banglaDin = [
    DayMonthModel(id: 1, name: 'রবিবার', audio: 'audio'),
    DayMonthModel(id: 2, name: 'সোমবার', audio: 'audio'),
    DayMonthModel(id: 3, name: 'মঙ্গলবার', audio: 'audio'),
    DayMonthModel(id: 4, name: 'বুধবার', audio: 'audio'),
    DayMonthModel(id: 5, name: 'বৃহস্পতিবার', audio: 'audio'),
    DayMonthModel(id: 6, name: 'শুক্রবার', audio: 'audio'),
    DayMonthModel(id: 7, name: 'শনিবার', audio: 'audio'),
  ];
}
