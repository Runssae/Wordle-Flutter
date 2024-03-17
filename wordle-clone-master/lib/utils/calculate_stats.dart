// Import shared preferences para mag-store ng data (to store data)
import 'package:shared_preferences/shared_preferences.dart';

// Function to calculate game statistics
calculateStats({required bool gameWon}) async {
  // Initialize variables to hold stats
  int gamesPlayed = 0,
      gamesWon = 0,
      winPercentage = 0,
      currentSteak = 0,
      maxStreak = 0;

  // Get previously saved stats
  final stats = await getStats();
  if (stats != null) {
    gamesPlayed = int.parse(stats[0]);
    gamesWon = int.parse(stats[1]);
    winPercentage = int.parse(stats[2]);
    currentSteak = int.parse(stats[3]);
    maxStreak = int.parse(stats[4]);
  }

  // Update games played
  gamesPlayed++;

  // Update wins and streaks based on game outcome
  if (gameWon) {
    gamesWon++;
    currentSteak++;
  } else {
    currentSteak = 0;
  }
  if (currentSteak > maxStreak) {
    maxStreak = currentSteak;
  }

  // Calculate win percentage
  winPercentage = ((gamesWon / gamesPlayed) * 100).toInt();

  // Save the updated stats
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('stats', [
    gamesPlayed.toString(),
    gamesWon.toString(),
    winPercentage.toString(),
    currentSteak.toString(),
    maxStreak.toString(),
  ]);
}

// Function to get previously saved stats
Future<List<String>?> getStats() async {
  final prefs = await SharedPreferences.getInstance();
  final stats = prefs.getStringList('stats');
  if (stats != null) {
    return stats;
  } else {
    return null;
  }
}
