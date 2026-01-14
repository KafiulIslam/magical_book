import 'package:flutter/material.dart';
import 'package:magical_book/core/constants/audio_path.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';
import '../../features/math/model/multiplication_model.dart';
import '../../features/arabic/model/allah_name_model.dart';
import '../../features/arabic/model/arabic_alphabet_model.dart';
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
      title: 'আল্লাহর ৯৯ নাম',
      subtitle: 'Names of Allah',
      icon: Icons.label_important_outline,
      color: AppColors.reward,
      route: Routes.arabicAllahNames,
    ),
    // Category(
    //   title: 'ইসলামিক ইতিহাস',
    //   subtitle: 'Islamic History',
    //   icon: Icons.history,
    //   color: AppColors.reward,
    //   route: Routes.arabicHistory,
    // ),
  ];

  // List of Arabic alphabet (ا to ي)
  static const List<ArabicAlphabetModel> arabicAlphabet = <ArabicAlphabetModel>[
    ArabicAlphabetModel(
      id: 1,
      letter: 'ا',
      audioPath: AudioPath.alif,
    ), // Alif
    ArabicAlphabetModel(
      id: 2,
      letter: 'ب',
      audioPath: AudioPath.ba,
    ), // Ba
    ArabicAlphabetModel(
      id: 3,
      letter: 'ت',
      audioPath: AudioPath.ta,
    ), // Ta
    ArabicAlphabetModel(
      id: 4,
      letter: 'ث',
      audioPath: AudioPath.cha,
    ), // Tha
    ArabicAlphabetModel(
      id: 5,
      letter: 'ج',
      audioPath: AudioPath.jim,
    ), // Jim
    ArabicAlphabetModel(
      id: 6,
      letter: 'ح',
      audioPath: AudioPath.ha,
    ), // Ha
    ArabicAlphabetModel(
      id: 7,
      letter: 'خ',
      audioPath: AudioPath.kho,
    ), // Kha
    ArabicAlphabetModel(
      id: 8,
      letter: 'د',
      audioPath: AudioPath.dal,
    ), // Dal
    ArabicAlphabetModel(
      id: 9,
      letter: 'ذ',
      audioPath: AudioPath.jal,
    ), // Dhal
    ArabicAlphabetModel(
      id: 10,
      letter: 'ر',
      audioPath: AudioPath.ro,
    ), // Ra
    ArabicAlphabetModel(
      id: 11,
      letter: 'ز',
      audioPath: AudioPath.ja,
    ), // Zay
    ArabicAlphabetModel(
      id: 12,
      letter: 'س',
      audioPath:AudioPath.sin,
    ), // Sin
    ArabicAlphabetModel(
      id: 13,
      letter: 'ش',
      audioPath: AudioPath.shin,
    ), // Shin
    ArabicAlphabetModel(
      id: 14,
      letter: 'ص',
      audioPath: AudioPath.soad,
    ), // Sad
    ArabicAlphabetModel(
      id: 15,
      letter: 'ض',
      audioPath: AudioPath.doat,
    ), // Dad (using dal as closest match)
    ArabicAlphabetModel(
      id: 16,
      letter: 'ط',
      audioPath: AudioPath.tow,
    ), // Ta
    ArabicAlphabetModel(
      id: 17,
      letter: 'ظ',
      audioPath: AudioPath.jow,
    ), // Za (using doat as closest match)
    ArabicAlphabetModel(
      id: 18,
      letter: 'ع',
      audioPath: AudioPath.ayen,
    ), // Ayn
    ArabicAlphabetModel(
      id: 19,
      letter: 'غ',
      audioPath: AudioPath.goyen,
    ), // Ghayn
    ArabicAlphabetModel(
      id: 20,
      letter: 'ف',
      audioPath: AudioPath.fa,
    ), // Fa
    ArabicAlphabetModel(
      id: 21,
      letter: 'ق',
      audioPath: AudioPath.kof,
    ), // Qaf
    ArabicAlphabetModel(
      id: 22,
      letter: 'ك',
      audioPath: AudioPath.kaf,
    ), // Kaf
    ArabicAlphabetModel(
      id: 23,
      letter: 'ل',
      audioPath: AudioPath.lam,
    ), // Lam
    ArabicAlphabetModel(
      id: 24,
      letter: 'م',
      audioPath: AudioPath.mim,
    ), // Mim
    ArabicAlphabetModel(
      id: 25,
      letter: 'ن',
      audioPath: AudioPath.nun,
    ), // Nun
    ArabicAlphabetModel(
      id: 26,
      letter: 'و',
      audioPath: AudioPath.wow,
    ), // wow

    ArabicAlphabetModel(
      id: 27,
      letter: 'ه',
      audioPath: AudioPath.ha,
    ), // W// aw
    ArabicAlphabetModel(
      id: 28,
      letter: 'لا',
      audioPath: AudioPath.lamAlif,
    ), //
    ArabicAlphabetModel(
      id: 29,
      letter: 'ء',
      audioPath: AudioPath.hamza,
    ), //
    ArabicAlphabetModel(
      id: 30,
      letter: 'ي',
      audioPath: AudioPath.ya,
    ), // Ya
  ];

  // Surah List
  static List<MultiplicationModel> surahList = [
    MultiplicationModel(
        id: 1,
        title: '১',
        subTitle: 'সূরাতুল ফাতিহা',
        image: AssetPath.fatiha,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 2,
        title: '২',
        subTitle: 'সূরাতুল আল-আসর',
        image: AssetPath.asar,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 3,
        title: '৩',
        subTitle: 'সূরাতুল ফালাক',
        image: AssetPath.falaq,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 4,
        title: '৪',
        subTitle: 'সূরাতুল ফিল',
        image: AssetPath.fil,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 5,
        title: '৫',
        subTitle: 'সূরাতুল ইখলাস',
        image: AssetPath.ikhlas,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 6,
        title: '৬',
        subTitle: 'সূরাতুল কাউসার',
        image: AssetPath.kawsar,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 7,
        title: '৭',
        subTitle: 'সূরাতুল কুরাইশ',
        image: AssetPath.kurais,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 8,
        title: '৮',
        subTitle: 'সূরাতুল নাস',
        image: AssetPath.nas,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 9,
        title: '৯',
        subTitle: 'সূরাতুল নাসর',
        image: AssetPath.nasr,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 10,
        title: '১০',
        subTitle: 'সূরাতুল লাহাব',
        image: AssetPath.lahab,
        audio: AudioPath.monerGhorete),
  ];

  // Surah List
  static List<MultiplicationModel> gojolList = [
    MultiplicationModel(
        id: 1,
        title: '১',
        subTitle: 'মনের ঘরেতে রেখেছি যারে',
        image: AssetPath.monerGhore,
        audio: AudioPath.monerGhorete),
    MultiplicationModel(
        id: 2,
        title: '২',
        subTitle: 'কুরআন মধুরও বানী',
        image: AssetPath.quranModhur,
        audio: AudioPath.quranModhur),
    MultiplicationModel(
        id: 3,
        title: '৩',
        subTitle: 'বাবা মানে হাজার বিকেল',
        image: AssetPath.babaMane,
        audio: AudioPath.babaMane),
    MultiplicationModel(
        id: 4,
        title: '৪',
        subTitle: 'আমি চাঁদকে বলি তুমি সুন্দর নও',
        image: AssetPath.chadKBoli,
        audio: AudioPath.chadKBoli),

    MultiplicationModel(
        id: 5,
        title: '৫',
        subTitle: 'ক্ষমা করে দাও, মাফ করে দাও',
        image: AssetPath.khomaKoreDao,
        audio: AudioPath.khomaKoreDao),
    MultiplicationModel(
        id: 6,
        title: '৬',
        subTitle: 'মেহেরবান তুমি মেহেরবান',
        image: AssetPath.meherban,
        audio: AudioPath.meherban),
    // need to change image
    MultiplicationModel(
        id: 7,
        title: '৭',
        subTitle: 'দুনিয়া সুন্দর',
        image: AssetPath.duniaSundor,
        audio: AudioPath.duniaSundor),
    MultiplicationModel(
        id: 8,
        title: '৮',
        subTitle: 'আল্লাহ তুমি অপরূপ',
        image: AssetPath.allahOporup,
        audio: AudioPath.allahTumi),
  ];

  // Surah List
  // static List<MultiplicationModel> historyList = [
  //   MultiplicationModel(
  //       id: 1,
  //       title: '৬',
  //       subTitle: 'মনের ঘরেতে রেখেছি যারে',
  //       image: AssetPath.monerGhore),
  //   MultiplicationModel(
  //       id: 2,
  //       title: '৭',
  //       subTitle: 'মুহাম্মাদ নাবীনা',
  //       image: AssetPath.muhammad),
  //   MultiplicationModel(
  //       id: 3,
  //       title: '৯',
  //       subTitle: 'কুরআন মধুরও বানী',
  //       image: AssetPath.quranModhur),
  //   MultiplicationModel(
  //       id: 4,
  //       title: '১',
  //       subTitle: 'বাবা মানে হাজার বিকেল',
  //       image: AssetPath.babaMane),
  //   MultiplicationModel(
  //       id: 5,
  //       title: '২',
  //       subTitle: 'আমি চাঁদকে বলি তুমি সুন্দর নও',
  //       image: AssetPath.chadKBoli),
  //   MultiplicationModel(
  //       id: 6,
  //       title: '৩',
  //       subTitle: 'হাজবি রাব্বি জাল্লাহ',
  //       image: AssetPath.hasbiRabbi),
  //   MultiplicationModel(
  //       id: 7,
  //       title: '৪',
  //       subTitle: 'লা ইলাহা ইল্লালাহ',
  //       image: AssetPath.laIlaha),
  //   MultiplicationModel(
  //       id: 8,
  //       title: '৫',
  //       subTitle: 'মেহেরবান তুমি মেহেরবান',
  //       image: AssetPath.meherban),
  //   MultiplicationModel(
  //       id: 9,
  //       title: '৮',
  //       subTitle: 'মুস্তফা মুস্তফা',
  //       image: AssetPath.mustafa),
  //   MultiplicationModel(
  //       id: 10,
  //       title: '১০',
  //       subTitle: 'রহমান ইয়া রহমান',
  //       image: AssetPath.rahman),
  // ];

  // 99 Names of Allah (Asma-ul-Husna)
  static const List<AllahNameModel> allahNames = [
    AllahNameModel(
      id: 1,
      arabicName: 'الله',
      banglaPronunciation: 'আল্লাহ',
      banglaMeaning: 'আল্লাহ, প্রভু',
    ),
    AllahNameModel(
      id: 2,
      arabicName: 'الرَّحْمَنُ',
      banglaPronunciation: 'আর-রহমান',
      banglaMeaning: 'সবচাইতে দয়ালু, কল্যাণময়, করুণাময়',
    ),
    AllahNameModel(
      id: 3,
      arabicName: 'الرَّحِيمُ',
      banglaPronunciation: 'আর-রহিম',
      banglaMeaning: 'সবচাইতে ক্ষমাশীল',
    ),
    AllahNameModel(
      id: 4,
      arabicName: 'الْمَلِكُ',
      banglaPronunciation: 'আল-মালিক',
      banglaMeaning: 'অধিপতি',
    ),
    AllahNameModel(
      id: 5,
      arabicName: 'الْقُدُّوسُ',
      banglaPronunciation: 'আল-ক্বুদ্দুস',
      banglaMeaning: 'পূতপবিত্র, নিখুঁত',
    ),
    AllahNameModel(
      id: 6,
      arabicName: 'السَّلَامُ',
      banglaPronunciation: 'আস-সালাম',
      banglaMeaning: 'শান্তি এবং নিরাপত্তার উৎস, ত্রাণকর্তা',
    ),
    AllahNameModel(
      id: 7,
      arabicName: 'الْمُؤْمِنُ',
      banglaPronunciation: 'আল-মুমিন',
      banglaMeaning: 'জামিনদার, সত্য ঘোষণাকারী',
    ),
    AllahNameModel(
      id: 8,
      arabicName: 'الْمُهَيْمِنُ',
      banglaPronunciation: 'আল-মুহাইমিন',
      banglaMeaning: 'অভিভাবক, প্রতিপালক',
    ),
    AllahNameModel(
      id: 9,
      arabicName: 'الْعَزِيزُ',
      banglaPronunciation: 'আল-আযিয',
      banglaMeaning: 'সর্বশক্তিমান, সবচেয়ে সম্মানিত',
    ),
    AllahNameModel(
      id: 10,
      arabicName: 'الْجَبَّارُ',
      banglaPronunciation: 'আল-জাব্বার',
      banglaMeaning: 'দুর্নিবার, সমু"চ, মহিমান্বিত',
    ),
    AllahNameModel(
      id: 11,
      arabicName: 'الْخَالِقُ',
      banglaPronunciation: 'আল-খলিক',
      banglaMeaning: 'সৃষ্টিকর্তা',
    ),
    AllahNameModel(
      id: 12,
      arabicName: 'الْبَارِئُ',
      banglaPronunciation: 'আল-বারি',
      banglaMeaning: 'বিবর্ধনকারী, নির্মাণকর্তা, পরিকল্পনাকারী',
    ),
    AllahNameModel(
      id: 13,
      arabicName: 'الْمُصَوِّرُ',
      banglaPronunciation: 'আল-মুসাউয়ির',
      banglaMeaning: 'আকৃতিদানকারী',
    ),
    AllahNameModel(
      id: 14,
      arabicName: 'الْغَفَّارُ',
      banglaPronunciation: 'আল-গাফফার',
      banglaMeaning: 'পুনঃমার্জনাকারী',
    ),
    AllahNameModel(
      id: 15,
      arabicName: 'الْقَهَّارُ',
      banglaPronunciation: 'আল-কাহ্হার',
      banglaMeaning: 'দমনকারী',
    ),
    AllahNameModel(
      id: 16,
      arabicName: 'الْوَهَّابُ',
      banglaPronunciation: 'আল-ওয়াহ্হাব',
      banglaMeaning: 'দানকারী',
    ),
    AllahNameModel(
      id: 17,
      arabicName: 'الرَّزَّاقُ',
      banglaPronunciation: 'আর-রজ্জাক',
      banglaMeaning: 'রিজিকদাতা',
    ),
    AllahNameModel(
      id: 18,
      arabicName: 'الْفَتَّاحُ',
      banglaPronunciation: 'আল-ফাত্তাহ',
      banglaMeaning: 'প্রারম্ভকারী, বিজয়দানকারী',
    ),
    AllahNameModel(
      id: 19,
      arabicName: 'الْعَلِيمُ',
      banglaPronunciation: 'আল-আলীম',
      banglaMeaning: 'সর্বজ্ঞানী, সর্বদর্শী',
    ),
    AllahNameModel(
      id: 20,
      arabicName: 'الْقَابِضُ',
      banglaPronunciation: 'আল-কাবিদ',
      banglaMeaning: 'নিয়ন্ত্রণকারী, সরলপথ প্রদর্শনকারী',
    ),
    AllahNameModel(
      id: 21,
      arabicName: 'الْبَاسِطُ',
      banglaPronunciation: 'আল-বাসিত',
      banglaMeaning: 'প্রসারণকারী',
    ),
    AllahNameModel(
      id: 22,
      arabicName: 'الْخَافِضُ',
      banglaPronunciation: 'আল-খাফিদ',
      banglaMeaning: '(অবিশ্বাসীদের) অপমানকারী',
    ),
    AllahNameModel(
      id: 23,
      arabicName: 'الرَّافِعُ',
      banglaPronunciation: 'আর-রাফি',
      banglaMeaning: 'উন্নীতকারী',
    ),
    AllahNameModel(
      id: 24,
      arabicName: 'الْمُعِزُّ',
      banglaPronunciation: 'আল-মুয়িজ্জিব',
      banglaMeaning: 'সম্মানপ্রদানকারী',
    ),
    AllahNameModel(
      id: 25,
      arabicName: 'الْمُذِلُّ',
      banglaPronunciation: 'আল-মুঝিল্ল',
      banglaMeaning: 'সম্মানহরণকারী',
    ),
    AllahNameModel(
      id: 26,
      arabicName: 'السَّمِيعُ',
      banglaPronunciation: 'আস-সামীয়ু',
      banglaMeaning: 'সর্বশ্রোতা',
    ),
    AllahNameModel(
      id: 27,
      arabicName: 'الْبَصِيرُ',
      banglaPronunciation: 'আল-বাসির',
      banglaMeaning: 'সর্বদ্রষ্টা',
    ),
    AllahNameModel(
      id: 28,
      arabicName: 'الْحَكَمُ',
      banglaPronunciation: 'আল-হাকাম',
      banglaMeaning: 'বিচারপতি',
    ),
    AllahNameModel(
      id: 29,
      arabicName: 'الْعَدْلُ',
      banglaPronunciation: 'আল-আদল',
      banglaMeaning: 'নিখুঁত',
    ),
    AllahNameModel(
      id: 30,
      arabicName: 'اللَّطِيفُ',
      banglaPronunciation: 'আল-লাতিফ',
      banglaMeaning: 'অমায়িক',
    ),
    AllahNameModel(
      id: 31,
      arabicName: 'الْخَبِيرُ',
      banglaPronunciation: 'আল-খবির',
      banglaMeaning: 'সম্যক অবগত',
    ),
    AllahNameModel(
      id: 32,
      arabicName: 'الْحَلِيمُ',
      banglaPronunciation: 'আল-হালিম',
      banglaMeaning: 'ধৈর্যবান, প্রশ্রয়দাতা',
    ),
    AllahNameModel(
      id: 33,
      arabicName: 'الْعَظِيمُ',
      banglaPronunciation: 'আল-আযিম',
      banglaMeaning: 'সুমহান',
    ),
    AllahNameModel(
      id: 34,
      arabicName: 'الْغَفُورُ',
      banglaPronunciation: 'আল-গফুর',
      banglaMeaning: 'মার্জনাকারী',
    ),
    AllahNameModel(
      id: 35,
      arabicName: 'الشَّكُورُ',
      banglaPronunciation: 'আশ-শাকুর',
      banglaMeaning: 'সুবিবেচক',
    ),
    AllahNameModel(
      id: 36,
      arabicName: 'الْعَلِيُّ',
      banglaPronunciation: 'আল-আলিই',
      banglaMeaning: 'মহীয়ান',
    ),
    AllahNameModel(
      id: 37,
      arabicName: 'الْكَبِيرُ',
      banglaPronunciation: 'আল-কাবীর',
      banglaMeaning: 'সুমহান',
    ),
    AllahNameModel(
      id: 38,
      arabicName: 'الْحَفِيظُ',
      banglaPronunciation: 'আল-হাফিজ',
      banglaMeaning: 'সংরক্ষণকারী',
    ),
    AllahNameModel(
      id: 39,
      arabicName: 'الْمُقِيتُ',
      banglaPronunciation: 'আল-মুকিত',
      banglaMeaning: 'লালনপালনকারী',
    ),
    AllahNameModel(
      id: 40,
      arabicName: 'الْحَسِيبُ',
      banglaPronunciation: 'আল-হাসিব',
      banglaMeaning: 'মীমাংসাকারী',
    ),
    AllahNameModel(
      id: 41,
      arabicName: 'الْجَلِيلُ',
      banglaPronunciation: 'আল-জালিল',
      banglaMeaning: 'গৌরবান্বিত',
    ),
    AllahNameModel(
      id: 42,
      arabicName: 'الْكَرِيمُ',
      banglaPronunciation: 'আল-কারিম',
      banglaMeaning: 'উদার, অকৃপণ',
    ),
    AllahNameModel(
      id: 43,
      arabicName: 'الرَّقِيبُ',
      banglaPronunciation: 'আর-রকিব',
      banglaMeaning: 'সদা জাগ্রত, অতন্দ্র পর্যবেক্ষণকারী',
    ),
    AllahNameModel(
      id: 44,
      arabicName: 'الْمُجِيبُ',
      banglaPronunciation: 'আল-মুজীব',
      banglaMeaning: 'সাড়া দানকারী, উত্তরদাতা',
    ),
    AllahNameModel(
      id: 45,
      arabicName: 'الْوَاسِعُ',
      banglaPronunciation: 'আল-ওয়াসি',
      banglaMeaning: 'অসীম, সর্বত্র বিরাজমান',
    ),
    AllahNameModel(
      id: 46,
      arabicName: 'الْحَكِيمُ',
      banglaPronunciation: 'আল-হাকিম',
      banglaMeaning: 'সুবিজ্ঞ, সুদক্ষ',
    ),
    AllahNameModel(
      id: 47,
      arabicName: 'الْوَدُودُ',
      banglaPronunciation: 'আল-ওয়াদুদ',
      banglaMeaning: 'স্নেহশীল',
    ),
    AllahNameModel(
      id: 48,
      arabicName: 'الْمَجِيدُ',
      banglaPronunciation: 'আল-মাজিদ',
      banglaMeaning: 'মহিমান্বিত',
    ),
    AllahNameModel(
      id: 49,
      arabicName: 'الْبَاعِثُ',
      banglaPronunciation: 'আল-বাঈস',
      banglaMeaning: 'পুনরুত্থানকারী',
    ),
    AllahNameModel(
      id: 50,
      arabicName: 'الشَّهِيدُ',
      banglaPronunciation: 'আশ-শাহীদ',
      banglaMeaning: 'সাক্ষ্যদানকারী',
    ),
    AllahNameModel(
      id: 51,
      arabicName: 'الْحَقُّ',
      banglaPronunciation: 'আল-হক',
      banglaMeaning: 'প্রকৃত সত্য',
    ),
    AllahNameModel(
      id: 52,
      arabicName: 'الْوَكِيلُ',
      banglaPronunciation: 'আল-ওয়াকিল',
      banglaMeaning: 'সহায় প্রদানকারী, আশ্রয়দাতা, উকিল',
    ),
    AllahNameModel(
      id: 53,
      arabicName: 'الْقَوِيُّ',
      banglaPronunciation: 'আল-কুওয়াত',
      banglaMeaning: 'ক্ষমতাশালী',
    ),
    AllahNameModel(
      id: 54,
      arabicName: 'الْمَتِينُ',
      banglaPronunciation: 'আল-মাতীন',
      banglaMeaning: 'সুদৃঢ়, সুস্থির',
    ),
    AllahNameModel(
      id: 55,
      arabicName: 'الْوَلِيُّ',
      banglaPronunciation: 'আল-ওয়ালিই',
      banglaMeaning: 'বন্ধু, সাহায্যকারী, শুভাকাক্সক্ষী',
    ),
    AllahNameModel(
      id: 56,
      arabicName: 'الْحَمِيدُ',
      banglaPronunciation: 'আল-হামিদ',
      banglaMeaning: 'সকল প্রশংসার দাবীদার, প্রশংসনীয়',
    ),
    AllahNameModel(
      id: 57,
      arabicName: 'الْمُحْصِي',
      banglaPronunciation: 'আল-মুহসি',
      banglaMeaning: 'বর্ণনাকারী, গণনাকারী',
    ),
    AllahNameModel(
      id: 58,
      arabicName: 'الْمُبْدِئُ',
      banglaPronunciation: 'আল-মুব্দি',
      banglaMeaning: 'অগ্রণী, প্রথম প্রবর্তক, সৃজনকর্তা',
    ),
    AllahNameModel(
      id: 59,
      arabicName: 'الْمُعِيدُ',
      banglaPronunciation: 'আল-মুঈদ',
      banglaMeaning: 'পুন:প্রতিষ্ঠাকারী, পুনরূদ্ধারকারি',
    ),
    AllahNameModel(
      id: 60,
      arabicName: 'الْمُحْيِي',
      banglaPronunciation: 'আল-মুহিই',
      banglaMeaning: 'জীবনদানকারী',
    ),
    AllahNameModel(
      id: 61,
      arabicName: 'الْمُمِيتُ',
      banglaPronunciation: 'আল-মুমীত',
      banglaMeaning: 'ধ্বংসকারী, মৃত্যু আনয়নকারী',
    ),
    AllahNameModel(
      id: 62,
      arabicName: 'الْحَيُّ',
      banglaPronunciation: 'আল-হাইই',
      banglaMeaning: 'চিরঞ্জীব, যার কোনো শেষ নাই',
    ),
    AllahNameModel(
      id: 63,
      arabicName: 'الْقَيُّومُ',
      banglaPronunciation: 'আল-কাইয়ুম',
      banglaMeaning: 'অভিভাবক, জীবিকানির্বাহ প্রদানকারী',
    ),
    AllahNameModel(
      id: 64,
      arabicName: 'الْوَاجِدُ',
      banglaPronunciation: 'আল-ওয়াজিদ',
      banglaMeaning: 'পর্যবেক্ষক, চিরস্থায়ী',
    ),
    AllahNameModel(
      id: 65,
      arabicName: 'الْمَاجِدُ',
      banglaPronunciation: 'আল-মাজিদ',
      banglaMeaning: 'সুপ্রসিদ্ধ',
    ),
    AllahNameModel(
      id: 66,
      arabicName: 'الْوَاحِدُ',
      banglaPronunciation: 'আল-ওয়াহিদ',
      banglaMeaning: 'এক, অনন্য, অদ্বিতীয়',
    ),
    AllahNameModel(
      id: 67,
      arabicName: 'الصَّمَدُ',
      banglaPronunciation: 'আস-সমাদ',
      banglaMeaning: 'চিরন্তন, অবিনশ্বর, নির্বিকল্প, সুনিপুণ, স্বয়ং সম্পূর্ণ',
    ),
    AllahNameModel(
      id: 68,
      arabicName: 'الْقَادِرُ',
      banglaPronunciation: 'আল-কাদির',
      banglaMeaning: 'সর্বশক্তিমান',
    ),
    AllahNameModel(
      id: 69,
      arabicName: 'الْمُقْتَدِرُ',
      banglaPronunciation: 'আল-মুকতাদির',
      banglaMeaning: 'প্রভাবশালী, সিদ্ধান্তগ্রহণকারী',
    ),
    AllahNameModel(
      id: 70,
      arabicName: 'الْمُقَدِّمُ',
      banglaPronunciation: 'আল-মুকাদ্দিম',
      banglaMeaning: 'অগ্রগতিতে সহায়তা প্রদানকারী',
    ),
    AllahNameModel(
      id: 71,
      arabicName: 'الْمُؤَخِّرُ',
      banglaPronunciation: 'আল-মুআক্ষির',
      banglaMeaning: 'বিলম্বকারী',
    ),
    AllahNameModel(
      id: 72,
      arabicName: 'الْأَوَّلُ',
      banglaPronunciation: 'আল-আউয়াল',
      banglaMeaning: 'সর্বপ্রথম, যার কোনো শুরু নাই',
    ),
    AllahNameModel(
      id: 73,
      arabicName: 'الْآخِرُ',
      banglaPronunciation: 'আল-আখির',
      banglaMeaning: 'সর্বশেষ, যার কোনো শেষ নাই',
    ),
    AllahNameModel(
      id: 74,
      arabicName: 'الظَّاهِرُ',
      banglaPronunciation: 'আজ-জাহির',
      banglaMeaning: 'সুস্পষ্ট, সুপ্রতীয়মান',
    ),
    AllahNameModel(
      id: 75,
      arabicName: 'الْبَاطِنُ',
      banglaPronunciation: 'আল-বাতিন',
      banglaMeaning: 'লুকায়িত, অস্পষ্ট, অন্তর্নিহিত (যা কিছু দেখা যায় না)',
    ),
    AllahNameModel(
      id: 76,
      arabicName: 'الْوَالِيَ',
      banglaPronunciation: 'আল-ওয়ালি',
      banglaMeaning: 'সুরক্ষাকারী বন্ধু, অনুগ্রহকারী, বন্ধুত্বপূর্ণ প্রভু',
    ),
    AllahNameModel(
      id: 77,
      arabicName: 'الْمُتَعَالِي',
      banglaPronunciation: 'আল-মুতাআলী',
      banglaMeaning: 'সর্বো"চ মহিমান্বিত, সুউ"চ',
    ),
    AllahNameModel(
      id: 78,
      arabicName: 'الْبَرُّ',
      banglaPronunciation: 'আল-র্বার',
      banglaMeaning: 'কল্যাণকারী',
    ),
    AllahNameModel(
      id: 79,
      arabicName: 'التَّوَّابُ',
      banglaPronunciation: 'আত-তাওয়াব',
      banglaMeaning: 'বিনম্র, সর্বদা আবর্তিতমান',
    ),
    AllahNameModel(
      id: 80,
      arabicName: 'الْمُنْتَقِمُ',
      banglaPronunciation: 'আল-মুন্তাকিম',
      banglaMeaning: 'প্রতিফল প্রদানকারী',
    ),
    AllahNameModel(
      id: 81,
      arabicName: 'الْعَفُوُّ',
      banglaPronunciation: 'আল-আফুউ',
      banglaMeaning: 'শাস্তি মউকুফকারী, গুনাহ ক্ষমাকারী',
    ),
    AllahNameModel(
      id: 82,
      arabicName: 'الرَّءُوفُ',
      banglaPronunciation: 'আর-রওফ',
      banglaMeaning: 'সদয়, সমবেদনা প্রকাশকারী',
    ),
    AllahNameModel(
      id: 83,
      arabicName: 'مَالِكُ الْمُلْكِ',
      banglaPronunciation: 'মালিকুল মুলক',
      banglaMeaning: 'সার্বভৌম ক্ষমতার অধিকারী',
    ),
    AllahNameModel(
      id: 84,
      arabicName: 'ذُو الْجَلَالِ وَالْإِكْرَامِ',
      banglaPronunciation: 'জুল-জালালি ওয়াল ইকরাম',
      banglaMeaning: 'মর্যাদা ও ঔদার্যের প্রভু',
    ),
    AllahNameModel(
      id: 85,
      arabicName: 'الْمُقْسِطُ',
      banglaPronunciation: 'আল-মুকসিত',
      banglaMeaning: 'ন্যায়পরায়ণ, প্রতিদানকারী',
    ),
    AllahNameModel(
      id: 86,
      arabicName: 'الْجَامِعُ',
      banglaPronunciation: 'আল-জামি',
      banglaMeaning: 'একত্র আনয়নকারী, ঐক্য সাধনকারী',
    ),
    AllahNameModel(
      id: 87,
      arabicName: 'الْغَنِيُّ',
      banglaPronunciation: 'আল-গানিই',
      banglaMeaning: 'ঐশ্বর্যবান, স্বতন্ত্র',
    ),
    AllahNameModel(
      id: 88,
      arabicName: 'الْمُغْنِي',
      banglaPronunciation: 'আল-মুগনি',
      banglaMeaning: 'সমৃদ্ধকারী, উদ্ধারকারী',
    ),
    AllahNameModel(
      id: 89,
      arabicName: 'الْمَانِعُ',
      banglaPronunciation: 'আল-মানি',
      banglaMeaning: 'প্রতিরোধকারী, রক্ষাকর্তা',
    ),
    AllahNameModel(
      id: 90,
      arabicName: 'الضَّارُّ',
      banglaPronunciation: 'আদ-র্দারু',
      banglaMeaning: 'যন্ত্রণাদানকারী, উৎপীড়নকারী',
    ),
    AllahNameModel(
      id: 91,
      arabicName: 'النَّافِعُ',
      banglaPronunciation: 'আন-নাফি',
      banglaMeaning: 'অনুগ্রাহক, উপকর্তা, হিতকারী',
    ),
    AllahNameModel(
      id: 92,
      arabicName: 'النُّورُ',
      banglaPronunciation: 'আন-নূর',
      banglaMeaning: 'আলোক',
    ),
    AllahNameModel(
      id: 93,
      arabicName: 'الْهَادِي',
      banglaPronunciation: 'আল-হাদী',
      banglaMeaning: 'পথপ্রদর্শক',
    ),
    AllahNameModel(
      id: 94,
      arabicName: 'الْبَدِيعُ',
      banglaPronunciation: 'আল-বাদী',
      banglaMeaning: 'অতুলনীয়, অনিধগম্য',
    ),
    AllahNameModel(
      id: 95,
      arabicName: 'الْبَاقِي',
      banglaPronunciation: 'আল-বাকী',
      banglaMeaning: 'অপরিবর্তনীয়, অনন্ত, অসীম, অক্ষয়',
    ),
    AllahNameModel(
      id: 96,
      arabicName: 'الْوَارِثُ',
      banglaPronunciation: 'আল-ওয়ারিস',
      banglaMeaning: 'সবকিছুর উত্তরাধিকারী',
    ),
    AllahNameModel(
      id: 97,
      arabicName: 'الرَّشِيدُ',
      banglaPronunciation: 'আর-রশিদ',
      banglaMeaning: 'সঠিক পথের নির্দেশক',
    ),
    AllahNameModel(
      id: 98,
      arabicName: 'الصَّبُورُ',
      banglaPronunciation: 'আস-সবুর',
      banglaMeaning: 'ধৈর্যশীল',
    ),
    AllahNameModel(
      id: 99,
      arabicName: 'الْمُتَكَبِّرُ',
      banglaPronunciation: 'আল-মুতাকাব্বির',
      banglaMeaning: 'সর্বশ্রেষ্ঠ, গৌরবান্বিত',
    ),
  ];
}
