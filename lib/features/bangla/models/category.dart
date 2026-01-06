import 'package:flutter/material.dart';

class Category {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  const Category(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.color,
      required this.route});
}
