// Import shared preferences for storing data
import 'package:shared_preferences/shared_preferences.dart';

// Class to manage theme preferences
class ThemePreferences {
  // Function to save the selected theme
  static saveTheme({required bool isDark}) async {
    // Get access to shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Store the theme preference (true for dark, false for light)
    prefs.setBool('isDark', isDark);
  }

  // Function to retrieve the saved theme preference
  static Future<bool> getTheme() async {
    // Get access to shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Get the stored theme preference, or return false if not found
    return prefs.getBool('isDark') ?? false;
  }
}
