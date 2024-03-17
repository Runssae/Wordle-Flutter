// Import libraries for charts and shared preferences
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

// Import the ChartModel class (likely defines data structure for charts)
import 'package:wordle_clone/models/chart_model.dart';

// Function to create chart data series (presumably for a bar chart)
Future<List<charts.Series<ChartModel, String>>> getSeries() async {
  // Initialize an empty list to hold chart data
  List<ChartModel> data = [];

  // Get access to shared preferences (used for storing data)
  final prefs = await SharedPreferences.getInstance();

  // Load saved scores (presumably an integer list)
  final scores = prefs.getStringList('chart');

  // Load the currently played row (likely an integer)
  final row = prefs.getInt('row');

  // If scores exist, convert them to ChartModel objects
  if (scores != null) {
    for (var e in scores) {
      data.add(ChartModel(score: int.parse(e), currentGame: false));
    }
  }

  // If a row is currently being played, highlight its score
  if (row != null) {
    data[row - 1].currentGame = true;
  }

  // Create two chart series with the same data (likely for visual effects)
  return [
    // First series configuration
    charts.Series<ChartModel, String>(
      id: 'Stats', // Series identifier
      data: data, // Chart data
      domainFn: (model, index) =>
          (index! + 1).toString(), // Generate x-axis labels (row numbers)
      measureFn: (model, index) => model.score, // Get y-axis values (scores)
      colorFn: (model, index) =>
          model.currentGame // Color based on current game
              ? charts.MaterialPalette.green.shadeDefault
              : charts.MaterialPalette.gray.shadeDefault,
      labelAccessorFn: (model, index) =>
          model.score.toString(), // Display scores on bars
    ),
    // Second series configuration (identical to the first)
    charts.Series<ChartModel, String>(
        id: 'Stats',
        data: data,
        domainFn: (model, index) {
          int i = index! + 1;
          return i.toString();
        },
        measureFn: (model, index) => model.score,
        colorFn: (model, index) {
          if (model.currentGame) {
            return charts.MaterialPalette.green.shadeDefault;
          } else {
            return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        labelAccessorFn: (model, index) => model.score.toString()),
  ];
}
