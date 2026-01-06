import 'package:flutter/cupertino.dart';

class FigureModel {
  final int id;
  final String title;
  final IconData image;
  final String audio;

  const FigureModel({
    required this.id,
    required this.title,
    required this.image,
    required this.audio,
  });
}
