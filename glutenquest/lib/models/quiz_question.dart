
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String category;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.category,
  });

  bool isCorrect(int selectedAnswerIndex) {
    return selectedAnswerIndex == correctAnswerIndex;
  }

  bool get hasValidAnswerIndex {
    return correctAnswerIndex >= 0 &&
        correctAnswerIndex < options.length;
  }
}
