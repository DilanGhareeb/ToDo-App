import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  ThemeNotifier() : super(false) {
    _loadDarkMode();
  }

  Future<void> _loadDarkMode() async {
    final isDarkMode = await _asyncPrefs.getBool('isDarkMode');
    state = isDarkMode ?? false;
  }

  Future<void> toggleDarkMode(bool value) async {
    await _asyncPrefs.setBool('isDarkMode', value);
    state = value;
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) {
    return ThemeNotifier();
  },
);
