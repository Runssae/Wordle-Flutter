// Import shared preferences for storing data
import 'package:shared_preferences/shared_preferences.dart';

// Function to store chart statistics
setChartStats({required int currentRow}) async {
  // Initialize a list to track distribution
  List<int> distribution = [0, 0, 0, 0, 0, 0];

  // Load any previously saved statistics
  final stats = await getStats();
  if (stats != null) {
    distribution = stats;
  }

  // Update the distribution based on the current row
  for (int i = 0; i < 6; i++) {
    if (currentRow - 1 == i) {
      distribution[i]++;
    }
  }

  // Convert the distribution to a list of strings for storage
  List<String> distributionString =
      distribution.map((e) => e.toString()).toList();

  // Save the distribution and current row to shared preferences
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('row', currentRow);
  prefs.setStringList('chart', distributionString);
}

// Function to retrieve chart statistics
Future<List<int>?> getStats() async {
  // Load data from shared preferences
  final prefs = await SharedPreferences.getInstance();
  final stats = prefs.getStringList('chart');

  // Convert the string list to a list of integers, if available
  if (stats != null) {
    return stats.map((e) => int.parse(e)).toList();
  } else {
    return null; // Return null if no data is found
  }
}
