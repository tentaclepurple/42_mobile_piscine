import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigation({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: AppConstants.navigationItems.asMap().entries.map((entry) {
          final int index = entry.key;
          final NavigationItem item = entry.value;
          
          return IconButton(
            icon: Icon(item.icon),
            color: selectedIndex == index ? Colors.blue : Colors.grey,
            onPressed: () => onItemSelected(index),
          );
        }).toList(),
      ),
    );
  }
}