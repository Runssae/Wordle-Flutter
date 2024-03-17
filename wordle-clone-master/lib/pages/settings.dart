import 'package:flutter/material.dart'; // Importing Flutter material library.
import 'package:provider/provider.dart'; // Importing Provider package for state management.
import 'package:shared_preferences/shared_preferences.dart'; // Importing SharedPreferences for storing data.
import 'package:wordle_clone/providers/theme_provider.dart'; // Importing custom theme provider.
import 'package:wordle_clone/utils/quick_box.dart'; // Importing custom utility for displaying quick messages.

import '../utils/theme_preferences.dart'; // Importing theme preferences.

class Settings extends StatelessWidget {
  // Creating a Settings widget.
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Building the Settings widget.
    return Scaffold(
      // Scaffold for building the UI structure.
      appBar: AppBar(
        // AppBar for the top bar of the screen.
        automaticallyImplyLeading: false, // Disabling automatic back button.
        title: const Text('Settings'), // Setting the title of the app bar.
        centerTitle: true, // Centering the title text.
        elevation: 0, // Setting elevation to 0 to remove shadow.
        actions: [
          // List of actions for the app bar.
          IconButton(
              // IconButton for clearing settings.
              onPressed: () {
                Navigator.maybePop(context); // Closing the settings screen.
              },
              icon: const Icon(Icons.clear)) // Adding a clear icon.
        ],
      ),
      body: Column(
        // Column for arranging UI elements vertically.
        children: [
          Consumer<ThemeProvider>(
            // Consumer for reading theme state.
            builder: (_, notifier, __) {
              // Builder for building UI based on theme state.
              bool _isSwitched = false; // Initializing switch state.
              _isSwitched = notifier.isDark; // Getting theme state.

              return SwitchListTile(
                // SwitchListTile for toggling dark theme.
                title: const Text('Dark Theme'), // Title for the switch tile.
                value: _isSwitched, // Current value of the switch.
                onChanged: (value) {
                  // Handling switch state change.
                  _isSwitched = value; // Updating switch state.
                  ThemePreferences.saveTheme(
                      isDark: _isSwitched); // Saving theme preference.
                  Provider.of<ThemeProvider>(context,
                          listen: false) // Updating theme using provider.
                      .setTheme(turnOn: _isSwitched);
                },
              );
            },
          ),
          ListTile(
            // ListTile for resetting statistics.
            title: const Text('Reset Statistics'), // Title for the list tile.
            onTap: () async {
              // Handling tap on list tile.
              final prefs = await SharedPreferences
                  .getInstance(); // Getting instance of SharedPreferences.
              prefs.remove('stats'); // Removing statistics data.
              prefs.remove('chart'); // Removing chart data.
              prefs.remove('row'); // Removing row data.
              runQuickBox(
                  context: context,
                  message: 'Statistics Reset'); // Displaying quick message.
            },
          )
        ],
      ),
    );
  }
}
