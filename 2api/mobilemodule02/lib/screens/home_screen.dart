// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/top_bar.dart';
import '../services/weather_service.dart';
import '../models/city.dart';
import 'views/currently_view.dart';
import 'views/today_view.dart';
import 'views/weekly_view.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  String _location = '';
  String _errorMessage = '';
  Map<String, dynamic>? _weatherData;
  final WeatherService _weatherService = WeatherService();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    setState(() {
      _errorMessage = message;
      _weatherData = null;
    });
  }

  void _clearError() {
    setState(() {
      _errorMessage = '';
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      _clearError();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('Geolocation is not available, please enable it in your App settings');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Geolocation is not available, please enable it in your App settings');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      final weatherData = await _weatherService.getWeather(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _location = '${position.latitude} ${position.longitude}';
        _weatherData = weatherData;
        _errorMessage = '';
      });
    } catch (e) {
      _showError('The service connection is lost, please check your internet connection or try again later');
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCitySelected(City city) async {
    try {
      if (city.latitude == 0 && city.longitude == 0) {
        _showError('Could not find any result for the supplied address or coordinates.');
        return;
      }

      _clearError();
      final weatherData = await _weatherService.getWeather(
        city.latitude,
        city.longitude,
      );
      setState(() {
        _location = '${city.name}, ${city.region}, ${city.country}';
        _weatherData = weatherData;
      });
    } catch (e) {
      _showError('The service connection is lost, please check your internet connection or try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onCitySelected: _onCitySelected,
        onGeolocation: _getCurrentLocation,
      ),
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          : PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              children: [
                CurrentlyView(
                  location: _location,
                  weatherData: _weatherData,
                ),
                TodayView(
                  location: _location,
                  weatherData: _weatherData,
                ),
                WeeklyView(
                  location: _location,
                  weatherData: _weatherData,
                ),
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