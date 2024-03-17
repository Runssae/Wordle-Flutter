enum AnswerStage {
  correct, // letter is in the correct position
  contains, // letter is part of the word but not in the correct position
  incorrect, // letter is not part of the word
  notAnswered, // letter has not been answered yet
}
