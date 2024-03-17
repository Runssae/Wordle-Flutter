import 'package:flutter/material.dart'; // Imports Flutter for building UI
import 'package:provider/provider.dart'; // Manages app state with Provider
import 'package:wordle_clone/providers/theme_provider.dart'; // Handles theme changes
import 'package:wordle_clone/utils/theme_preferences.dart'; // Loads saved theme preference

import 'constants/themes.dart'; // Stores light and dark theme definitions
import 'providers/controller.dart'; // Provides app-wide functionality (replace with actual functionality)
import 'pages/home_page.dart'; // The main screen of the app

void main() {
  runApp(const MyApp()); // Starts the app with MyApp widget
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Controller()), // Provides app controller
        ChangeNotifierProvider(
            create: (_) => ThemeProvider()), // Provides theme management
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(), // Loads preferred theme
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Set theme based on saved preference after the first frame renders
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) =>
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(turnOn: snapshot.data as bool));
          }
          return Consumer<ThemeProvider>(
            builder: (_, notifier, __) => MaterialApp(
              debugShowCheckedModeBanner: false, // Hides debug banner
              title: 'Wordle Clone',
              theme: notifier.isDark ? darkTheme : lightTheme, // Applies theme
              home: const Material(child: HomePage()), // Sets home screen
            ),
          );
        },
      ),
    );
  }
}
