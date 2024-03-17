import 'package:wordle_clone/constants/answer_stages.dart'; // Importing AnswerStage enum

class TileModel {
  final String letter; // Letter displayed on the tile
  AnswerStage answerStage; // Stage of the answer for this tile

  TileModel(
      {required this.letter,
      required this.answerStage}); // Constructor for TileModel
}
