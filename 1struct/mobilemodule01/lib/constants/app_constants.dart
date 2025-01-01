import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.icon,
    required this.label,
  });
}

class AppConstants {
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      icon: Icons.cloud,
      label: 'Currently',
    ),
    NavigationItem(
      icon: Icons.today,
      label: 'Today',
    ),
    NavigationItem(
      icon: Icons.calendar_view_week,
      label: 'Weekly',
    ),
  ];
}