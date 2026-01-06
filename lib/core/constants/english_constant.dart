import 'package:flutter/material.dart';
import 'package:magical_book/core/router/routes.dart';
import 'package:magical_book/features/bangla/models/common_content_model.dart';
import 'package:magical_book/features/english/model/figure_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/bangla/models/category.dart';
import '../../features/bangla/models/day_month_model.dart';
import '../../features/english/model/rhymes_model.dart';
import 'asset_path.dart';

// Contains all constant values and lists related to English feature
class EnglishConstants {
  // List of English learning categories
  static const List<Category> englishCategories = [
    Category(
      title: 'Alphabet',
      subtitle: 'English Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
      route: Routes.englishAlphabet,
    ),
    Category(
      title: 'Rhymes',
      subtitle: 'English Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
      route: Routes.englishRhymes,
    ),
    Category(
      title: 'Fruits',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
      route: Routes.englishFruits,
    ),
    Category(
      title: 'Flowers',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
      route: Routes.englishFlowers,
    ),
    Category(
      title: 'Figures',
      subtitle: 'Figures & Shapes',
      icon: Icons.looks,
      color: AppColors.info,
      route: Routes.englishFigures,
    ),
    Category(
      title: 'Body Parts',
      subtitle: 'Body Parts',
      icon: Icons.accessibility,
      color: AppColors.primary,
      route: Routes.englishBodyParts,
    ),
    Category(
      title: 'Days',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
      route: Routes.englishDays,
    ),
    Category(
      title: 'Months',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.action,
      route: Routes.englishMonths,
    ),
    Category(
      title: 'Animals',
      subtitle: 'Animal Names',
      icon: Icons.pets,
      color: AppColors.action,
      route: Routes.englishAnimals,
    ),
    Category(
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
  static const List<CommonContentModel> fruitsName = [
    CommonContentModel(
        id: 1, title: 'Mango', image: AssetPath.mango, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'Apple', image: AssetPath.apple, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'Banana', image: AssetPath.banana, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'Orange', image: AssetPath.orange, audio: 'audio'),
    CommonContentModel(
        id: 5,
        title: 'Water Melon',
        image: AssetPath.waterMelon,
        audio: 'audio'),
    CommonContentModel(
        id: 6, title: 'Pine Apple', image: AssetPath.pineApple, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'Grapes', image: AssetPath.grape, audio: 'audio'),
    CommonContentModel(
        id: 8, title: 'Jack Fruit', image: AssetPath.jackFruit, audio: 'audio'),
  ];

  // flowers
  static const List<CommonContentModel> flowers = [
    CommonContentModel(
        id: 1, title: 'Water Lily', image: AssetPath.shapla, audio: 'audio'),
    CommonContentModel(id: 2, title: 'Rose', image: AssetPath.golap, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'Hibiscus', image: AssetPath.joba, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'Marigold', image: AssetPath.gadha, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'Sun Flower', image: AssetPath.surjo, audio: 'audio'),
    // BanglaFulModel(id: 6, name: 'বেলি', image: AssetPath.surjo, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'Parijat', image: AssetPath.shuly, audio: 'audio'),
    CommonContentModel(
        id: 8, title: 'Spanish Cherry', image: AssetPath.bokul, audio: 'audio'),
    CommonContentModel(
        id: 9,
        title: 'Flamboyant',
        image: AssetPath.krisnochura,
        audio: 'audio'),
  ];

  // Figures & Shape
  static const List<FigureModel> figures = [
    FigureModel(
        id: 1, title: 'Circle',image: Icons.circle, audio: 'audio'),
    FigureModel(id: 2, title: 'Square', image: Icons.square, audio: 'audio'),
    FigureModel(
        id: 3, title: 'Triangle', image: Icons.change_history_outlined, audio: 'audio'),
    FigureModel(
        id: 4, title: 'Rectangle', image: Icons.rectangle, audio: 'audio'),
    // FigureModel(
    //     id: 5, title: 'Rhombus', image: Icons.diamond, audio: 'audio'),
    FigureModel(id: 6, title: 'Hexagon', image: Icons.hexagon, audio: 'audio'),
    // FigureModel(
    //     id: 7, title: 'Semi Circle', image: Icons.circl, audio: 'audio'),
    FigureModel(
        id: 8, title: 'Pentagon', image: Icons.pentagon, audio: 'audio'),
    FigureModel(
        id: 9,
        title: 'Star',
        image: Icons.star,
        audio: 'audio'),

     // FigureModel(id: 10, title: 'Oval', image: Icons.egg, audio: 'audio'),
    // FigureModel(
    //     id: 11, title: 'Cylinder', image: AssetPath.shuly, audio: 'audio'),
    FigureModel(
        id: 12, title: 'Heart', image: Icons.favorite_outlined, audio: 'audio'),
    // FigureModel(
    //     id: 13,
    //     title: 'Cone',
    //     image: AssetPath.krisnochura,
    //     audio: 'audio'),
  ];

  // flowers
  static const List<CommonContentModel> humanBody = [
    CommonContentModel(id: 1, title: 'Head', image: AssetPath.head, audio: 'audio'),
    CommonContentModel(id: 2, title: 'Eye', image: AssetPath.eye, audio: 'audio'),
    CommonContentModel(id: 3, title: 'Ear', image: AssetPath.ear, audio: 'audio'),
    CommonContentModel(id: 3, title: 'Hand', image: AssetPath.hand, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'Mouth', image: AssetPath.mouth, audio: 'audio'),
    CommonContentModel(id: 5, title: 'Nose', image: AssetPath.nose, audio: 'audio'),
    CommonContentModel(id: 8, title: 'Leg', image: AssetPath.leg, audio: 'audio'),
    CommonContentModel(id: 6, title: 'Feet', image: AssetPath.feet, audio: 'audio'),
    CommonContentModel(id: 7, title: 'Arm', image: AssetPath.arm, audio: 'audio'),
    CommonContentModel(id: 8, title: 'Hair', image: AssetPath.hair, audio: 'audio'),
    CommonContentModel(
        id: 8, title: 'Forehead', image: AssetPath.forehead, audio: 'audio'),
    CommonContentModel(
        id: 9, title: 'Finger', image: AssetPath.finger, audio: 'audio'),
    CommonContentModel(id: 10, title: 'Knee', image: AssetPath.knee, audio: 'audio'),
    CommonContentModel(
        id: 11, title: 'Belly', image: AssetPath.belly, audio: 'audio'),
    CommonContentModel(
        id: 12, title: 'Tongue', image: AssetPath.tongue, audio: 'audio'),
  ];

  // English Days
  static const List<DayMonthModel> englishDays = [
    DayMonthModel(id: 1, name: 'Sunday', audio: 'audio'),
    DayMonthModel(id: 2, name: 'Monday', audio: 'audio'),
    DayMonthModel(id: 3, name: 'Tuesday', audio: 'audio'),
    DayMonthModel(id: 4, name: 'Wednesday', audio: 'audio'),
    DayMonthModel(id: 5, name: 'Thursday', audio: 'audio'),
    DayMonthModel(id: 6, name: 'Friday', audio: 'audio'),
    DayMonthModel(id: 7, name: 'Saturday', audio: 'audio'),
  ];

  // English Months
  static const List<DayMonthModel> englishMonths = [
    DayMonthModel(id: 1, name: 'January', audio: 'audio'),
    DayMonthModel(id: 2, name: 'February', audio: 'audio'),
    DayMonthModel(id: 3, name: 'March', audio: 'audio'),
    DayMonthModel(id: 4, name: 'April', audio: 'audio'),
    DayMonthModel(id: 5, name: 'May', audio: 'audio'),
    DayMonthModel(id: 6, name: 'June', audio: 'audio'),
    DayMonthModel(id: 7, name: 'July', audio: 'audio'),
    DayMonthModel(id: 8, name: 'August', audio: 'audio'),
    DayMonthModel(id: 9, name: 'September', audio: 'audio'),
    DayMonthModel(id: 10, name: 'October', audio: 'audio'),
    DayMonthModel(id: 11, name: 'November', audio: 'audio'),
    DayMonthModel(id: 12, name: 'December', audio: 'audio'),
  ];

  // Animals
  static const  List<CommonContentModel> animals = [
    CommonContentModel(id: 1, title: 'Fox', image: AssetPath.fox, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'Panda', image: AssetPath.panda, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'Zebra', image: AssetPath.zebra, audio: 'audio'),
    CommonContentModel(
        id: 4, title: 'Monkey', image: AssetPath.monkey, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'Kangaroo', image: AssetPath.kangaroo, audio: 'audio'),
    CommonContentModel(id: 6, title: 'Bear', image: AssetPath.bear, audio: 'audio'),
    CommonContentModel(
        id: 7, title: 'Tiger', image: AssetPath.tiger, audio: 'audio'),
    CommonContentModel(id: 8, title: 'Lion', image: AssetPath.lion, audio: 'audio'),
  ];

  // Birds
  static const List<CommonContentModel> birds = [
    CommonContentModel(
        id: 1, title: 'Peacock', image: AssetPath.peacock, audio: 'audio'),
    CommonContentModel(
        id: 2, title: 'Magpie', image: AssetPath.magpie, audio: 'audio'),
    CommonContentModel(
        id: 3, title: 'Vulture', image: AssetPath.vulture, audio: 'audio'),
    CommonContentModel(id: 4, title: 'Crow', image: AssetPath.crow, audio: 'audio'),
    CommonContentModel(
        id: 5, title: 'Eagle', image: AssetPath.eagle, audio: 'audio'),
    CommonContentModel(
        id: 6, title: 'Pigeon', image: AssetPath.pigeon, audio: 'audio'),
  ];

}
