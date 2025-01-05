// lib/widgets/top_bar.dart
import 'package:flutter/material.dart';
import '../models/city.dart';
import '../services/geocoding_service.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(City) onCitySelected;
  final VoidCallback onGeolocation;

  const TopBar({
    required this.onCitySelected,
    required this.onGeolocation,
    super.key,
  });

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
  final GeocodingService _geocodingService = GeocodingService();
  List<City> _suggestions = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final TextEditingController _textController = TextEditingController();

  void _showSuggestions(List<City> suggestions) {
    _removeOverlay();
    if (suggestions.isEmpty) return;
    _overlayEntry = _createOverlayEntry(suggestions);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleSearch(String query) async {
    try {
      final RegExp validQuery = RegExp(r'^(?!\s*$)[a-zA-Z\s-]+$');
      if (!validQuery.hasMatch(query)) {
        widget.onCitySelected(City(
          name: query,
          region: '',
          country: '',
          latitude: 0,
          longitude: 0,
        ));
        _removeOverlay();
        return;
      }

      final cities = await _geocodingService.searchCities(query);
      if (cities.isNotEmpty) {
        widget.onCitySelected(cities.first);
      } else {
        widget.onCitySelected(City(
          name: query,
          region: '',
          country: '',
          latitude: 0,
          longitude: 0,
        ));
      }
      _removeOverlay();
    } catch (e) {
      widget.onCitySelected(City(
        name: query,
        region: '',
        country: '',
        latitude: 0,
        longitude: 0,
      ));
      _removeOverlay();
    }
  }

  OverlayEntry _createOverlayEntry(List<City> suggestions) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            child: Column(
              children: suggestions
                  .map((city) => ListTile(
                        title: Text(city.name),
                        subtitle: Text('${city.region}, ${city.country}'),
                        onTap: () {
                          widget.onCitySelected(city);
                          _textController.text = city.name;
                          _removeOverlay();
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          controller: _textController,
          onChanged: (value) async {
            if (value.length >= 2) {
              final suggestions = await _geocodingService.searchCities(value);
              setState(() {
                _suggestions = suggestions;
              });
              _showSuggestions(suggestions);
            } else {
              _removeOverlay();
            }
          },
          onSubmitted: _handleSearch,
          decoration: const InputDecoration(
            hintText: 'Search location...',
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: widget.onGeolocation,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _removeOverlay();
    super.dispose();
  }
}