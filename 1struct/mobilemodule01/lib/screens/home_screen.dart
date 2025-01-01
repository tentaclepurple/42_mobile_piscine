// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/top_bar.dart';
import 'views/currently_view.dart';
import 'views/today_view.dart';
import 'views/weekly_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  String _location = '';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch(String value) {
    setState(() {
      _location = value;
    });
  }

  void _onGeolocation() {
    setState(() {
      _location = 'Geolocation';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onSearch: _onSearch,
        onGeolocation: _onGeolocation,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const ClampingScrollPhysics(),
        children: [
          CurrentlyView(location: _location),
          TodayView(location: _location),
          WeeklyView(location: _location),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}