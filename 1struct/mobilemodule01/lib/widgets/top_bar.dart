// lib/widgets/top_bar.dart
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearch;
  final VoidCallback onGeolocation;

  const TopBar({
    required this.onSearch,
    required this.onGeolocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        onChanged: onSearch,
        decoration: const InputDecoration(
          hintText: 'Search location...',
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: onGeolocation,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}