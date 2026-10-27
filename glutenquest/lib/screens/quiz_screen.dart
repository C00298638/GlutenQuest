
import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  bool answerSubmitted = false;

  QuizQuestion get currentQuestion =>
      quizQuestions[currentQuestionIndex];

  void selectAnswer(int index) {
    if (answerSubmitted) return;

    setState(() {
      selectedAnswerIndex = index;
      answerSubmitted = true;

      if (currentQuestion.isCorrect(index)) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        answerSubmitted = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score: score,
            totalQuestions: quizQuestions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = currentQuestion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GlutenQuest Quiz'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1} '
                'of ${quizQuestions.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) /
                    quizQuestions.length,
                color: Colors.green,
                backgroundColor: Colors.green.shade100,
              ),
              const SizedBox(height: 24),
              Text(
                question.category,
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question.question,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (index) {
                final isSelected = selectedAnswerIndex == index;
                final isCorrect = index == question.correctAnswerIndex;

                Color? backgroundColor;

                if (answerSubmitted && isCorrect) {
                  backgroundColor = Colors.green.shade100;
                } else if (answerSubmitted && isSelected && !isCorrect) {
                  backgroundColor = Colors.red.shade100;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: backgroundColor,
                    child: ListTile(
                      title: Text(question.options[index]),
                      trailing: answerSubmitted && isCorrect
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : answerSubmitted && isSelected
                              ? const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )
                              : null,
                      onTap: () => selectAnswer(index),
                    ),
                  ),
                );
              }),
              if (answerSubmitted) ...[
                const SizedBox(height: 8),
                Text(
                  currentQuestion.isCorrect(selectedAnswerIndex!)
                      ? 'Correct! Well done!'
                      : 'Not quite. Learn from the explanation below.',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(question.explanation),
              ],
              const SizedBox(height: 20),
              Text(
                'Score: $score / ${quizQuestions.length}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: answerSubmitted ? nextQuestion : null,
                child: Text(
                  currentQuestionIndex == quizQuestions.length - 1
                      ? 'See Results'
                      : 'Next Question',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalQuestions == 0
        ? 0
        : (score / totalQuestions * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Quiz Complete!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'You scored $score out of $totalQuestions',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text('$percentage% correct'),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
