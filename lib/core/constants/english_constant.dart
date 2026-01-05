import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/bangla_category.dart';
import '../../features/bangla/models/bangla_fol_model.dart';
import '../../features/bangla/models/bangla_ful_model.dart';
import '../../features/bangla/models/bangla_din_model.dart';
import '../../features/bangla/models/bangla_mas_model.dart';
import '../../features/english/model/rhymes_model.dart';
import 'asset_path.dart';

 // Contains all constant values and lists related to English feature
class EnglishConstants {


  // List of English learning categories
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
      icon: Icons.air_outlined,
      color: AppColors.action,
      route: Routes.englishBirds,
    ),
  ];

  // List of English alphabet (A to Z)
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
        title: 'Rain Rain Go Away',
        image: AssetPath.rainRain,
        audio: 'audio'),
    const RhymesModel(
        id: 2,
        title: 'Brush, Brush, Brush Your Teeth',
        image: AssetPath.brush,
        audio: 'audio'),
    const RhymesModel(
        id: 3, title: 'Pussy Cat', image: AssetPath.pussyCat, audio: 'audio'),
    const RhymesModel(
        id: 4,
        title: 'Rainbow Fish',
        image: AssetPath.rainbowFish,
        audio: 'audio'),
    const RhymesModel(
        id: 5,
        title: 'Roses are red',
        image: AssetPath.redRose,
        audio: 'audio'),
    const RhymesModel(
        id: 6,
        title: 'Teddy Bear, Teddy Bear',
        image: AssetPath.teddy,
        audio: 'audio'),
    const RhymesModel(
        id: 7,
        title: 'A wise old owl',
        image: AssetPath.wiseOwl,
        audio: 'audio'),
    const RhymesModel(
        id: 8,
        title: 'Little boy blue',
        image: AssetPath.blueBoy,
        audio: 'audio'),
    const RhymesModel(
        id: 9,
        title: 'Jack and jill',
        image: AssetPath.jackJill,
        audio: 'audio'),
  ];

  // fruits name
  static List<BanglaFolModel> fruitsName = [
    BanglaFolModel(id: 1, name: 'Mango', image: AssetPath.mango, audio: 'audio'),
    BanglaFolModel(id: 3, name: 'Apple', image: AssetPath.apple, audio: 'audio'),
    BanglaFolModel(id: 2, name: 'Banana', image: AssetPath.banana, audio: 'audio'),
    BanglaFolModel(
        id: 4, name: 'Orange', image: AssetPath.orange, audio: 'audio'),
    BanglaFolModel(
        id: 5, name: 'Water Melon', image: AssetPath.waterMelon, audio: 'audio'),
    BanglaFolModel(
        id: 6, name: 'Pine Apple', image: AssetPath.pineApple, audio: 'audio'),
    BanglaFolModel(
        id: 7, name: 'Grapes', image: AssetPath.grape, audio: 'audio'),
    BanglaFolModel(
        id: 8, name: 'Jack Fruit', image: AssetPath.jackFruit, audio: 'audio'),
  ];

  // flowers
  static List<BanglaFulModel> flowers = [
    BanglaFulModel(
        id: 1, name: 'Water Lily', image: AssetPath.shapla, audio: 'audio'),
    BanglaFulModel(
        id: 2, name: 'Rose', image: AssetPath.golap, audio: 'audio'),
    BanglaFulModel(id: 3, name: 'Hibiscus', image: AssetPath.joba, audio: 'audio'),
    BanglaFulModel(
        id: 4, name: 'Marigold', image: AssetPath.gadha, audio: 'audio'),
    BanglaFulModel(
        id: 5, name: 'Sun Flower', image: AssetPath.surjo, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    BanglaFulModel(
        id: 7, name: 'Parijat', image: AssetPath.shuly, audio: 'audio'),
    BanglaFulModel(id: 8, name: 'Spanish Cherry', image: AssetPath.bokul, audio: 'audio'),
    BanglaFulModel(
        id: 9, name: 'Flamboyant', image: AssetPath.krisnochura, audio: 'audio'),
  ];

  // flowers
  static List<BanglaFulModel> humanBody = [
    BanglaFulModel(
        id: 1, name: 'Head', image: AssetPath.head, audio: 'audio'),
    BanglaFulModel(
        id: 2, name: 'Eye', image: AssetPath.eye, audio: 'audio'),
    BanglaFulModel(id: 3, name: 'Ear', image: AssetPath.ear, audio: 'audio'),
    BanglaFulModel(
        id: 3, name: 'Hand', image: AssetPath.hand, audio: 'audio'),
    BanglaFulModel(
        id: 4, name: 'Mouth', image: AssetPath.mouth, audio: 'audio'),

    BanglaFulModel(
        id: 5, name: 'Nose', image: AssetPath.nose, audio: 'audio'),
    BanglaFulModel(id: 8, name: 'Leg', image: AssetPath.leg, audio: 'audio'),
    BanglaFulModel(
        id: 6, name: 'Feet', image: AssetPath.feet, audio: 'audio'),
    BanglaFulModel(
        id: 7, name: 'Arm', image: AssetPath.arm, audio: 'audio'),
    BanglaFulModel(id: 8, name: 'Hair', image: AssetPath.hair, audio: 'audio'),
    BanglaFulModel(
        id: 8, name: 'Forehead', image: AssetPath.forehead, audio: 'audio'),
    BanglaFulModel(
        id: 9, name: 'Finger', image: AssetPath.finger, audio: 'audio'),
    BanglaFulModel(id: 10, name: 'Knee', image: AssetPath.knee, audio: 'audio'),
    BanglaFulModel(
        id: 11, name: 'Belly', image: AssetPath.belly, audio: 'audio'),
    BanglaFulModel(
        id: 12, name: 'Tongue', image: AssetPath.tongue, audio: 'audio'),
  ];

  // English Days
  static const List<BanglaDinModel> englishDays = [
    BanglaDinModel(id: 1, name: 'Sunday', audio: 'audio'),
    BanglaDinModel(id: 2, name: 'Monday', audio: 'audio'),
    BanglaDinModel(id: 3, name: 'Tuesday', audio: 'audio'),
    BanglaDinModel(id: 4, name: 'Wednesday', audio: 'audio'),
    BanglaDinModel(id: 5, name: 'Thursday', audio: 'audio'),
    BanglaDinModel(id: 6, name: 'Friday', audio: 'audio'),
    BanglaDinModel(id: 7, name: 'Saturday', audio: 'audio'),
  ];

  // English Months
  static const List<BanglaMasModel> englishMonths = [
    BanglaMasModel(id: 1, name: 'January', audio: 'audio'),
    BanglaMasModel(id: 2, name: 'February', audio: 'audio'),
    BanglaMasModel(id: 3, name: 'March', audio: 'audio'),
    BanglaMasModel(id: 4, name: 'April', audio: 'audio'),
    BanglaMasModel(id: 5, name: 'May', audio: 'audio'),
    BanglaMasModel(id: 6, name: 'June', audio: 'audio'),
    BanglaMasModel(id: 7, name: 'July', audio: 'audio'),
    BanglaMasModel(id: 8, name: 'August', audio: 'audio'),
    BanglaMasModel(id: 9, name: 'September', audio: 'audio'),
    BanglaMasModel(id: 10, name: 'October', audio: 'audio'),
    BanglaMasModel(id: 11, name: 'November', audio: 'audio'),
    BanglaMasModel(id: 12, name: 'December', audio: 'audio'),
  ];

  // Animals
  static const List<BanglaMasModel> animals = [
    BanglaMasModel(id: 1, name: 'Fox', audio: 'audio'),
    BanglaMasModel(id: 2, name: 'Panda', audio: 'audio'),
    BanglaMasModel(id: 3, name: 'Zebra', audio: 'audio'),
    BanglaMasModel(id: 4, name: 'Monkey', audio: 'audio'),
    BanglaMasModel(id: 5, name: 'Kangaroo', audio: 'audio'),
    BanglaMasModel(id: 6, name: 'Bear', audio: 'audio'),
    BanglaMasModel(id: 7, name: 'Tiger', audio: 'audio'),
    BanglaMasModel(id: 8, name: 'Lion', audio: 'audio'),
  ];


  // Animals
  static const List<BanglaMasModel> birds = [
    BanglaMasModel(id: 1, name: 'Peacock', audio: 'audio'),
    BanglaMasModel(id: 2, name: 'Magpie', audio: 'audio'),
    BanglaMasModel(id: 3, name: 'Vulture', audio: 'audio'),
    BanglaMasModel(id: 4, name: 'Crow', audio: 'audio'),
    BanglaMasModel(id: 5, name: 'Eagle', audio: 'audio'),
  ];

}
