import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  static const String _colorKey = 'appbar_color_value';

  // Available AppBar colors: Blue, Green, Purple, and others to match dialog UI
  static const List<Color> availableColors = [
    Color(0xFF2E384D),
    Color(0xFF1E88E5),
    Color(0xFF43A047),
    Color(0xFF8E24AA),
    Color(0xFFE53935),
    Color(0xFF00897B),
    Color(0xFFFB8C00),
    Color(0xFF3949AB),
  ];

  @override
  Color build() {
    _loadColor();
    return availableColors[0];
  }

  Future<void> _loadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorVal = prefs.getInt(_colorKey);
    if (colorVal != null) {
      state = Color(colorVal);
    }
  }

  Future<void> setColor(Color color) async {
    state = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, color.toARGB32());
  }
}
