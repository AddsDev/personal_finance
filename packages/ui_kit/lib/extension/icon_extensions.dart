import 'package:flutter/material.dart';

extension InconDataMapExtension on BuildContext {
  IconData mapIconData(String key) {
    switch (key) {
      case 'fastfood':
        return Icons.fastfood;
      case 'work':
        return Icons.work;
      case 'directions_car':
        return Icons.directions_car;
      case 'home':
        return Icons.home;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'movie':
        return Icons.movie;
      case 'health_and_safety':
        return Icons.health_and_safety;
      default:
        return Icons.category;
    }
  }
}
