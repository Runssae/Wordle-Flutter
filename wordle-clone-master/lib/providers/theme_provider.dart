// Import Flutter for building UI elements
import 'package:flutter/material.dart';

// Class to manage theme settings
class ThemeProvider extends ChangeNotifier {
  // Stores the current theme preference (dark or light)
  bool isDark = false;

  // Method to set the theme
  setTheme({required bool turnOn}) {
    // Update the theme preference
    isDark = turnOn;
    // Notify listeners of the change (e.g., widgets using this provider)
    notifyListeners();
  }
}
