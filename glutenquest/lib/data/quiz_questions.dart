
import '../models/quiz_question.dart';

const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    id: 'q1',
    question: 'Which of these grains contains gluten?',
    options: [
      'Rice',
      'Wheat',
      'Corn',
      'Potatoes',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Wheat contains gluten. Rice, corn and potatoes are naturally gluten-free.',
    category: 'Gluten Basics',
  ),
  QuizQuestion(
    id: 'q2',
    question: 'Which food is naturally gluten-free?',
    options: [
      'Regular wheat bread',
      'Barley soup',
      'Plain rice',
      'Wheat pasta',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Plain rice is naturally gluten-free. Check additional ingredients '
        'and preparation methods when choosing food.',
    category: 'Food Safety',
  ),
  QuizQuestion(
    id: 'q3',
    question: 'Why should you check food labels?',
    options: [
      'To check the price',
      'To find hidden sources of gluten',
      'To see the food colour',
      'To check the package size',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Processed foods can contain gluten-containing ingredients. '
        'Read the ingredients and allergen information carefully.',
    category: 'Reading Labels',
  ),
  QuizQuestion(
    id: 'q4',
    question: 'What is gluten cross-contamination?',
    options: [
      'Eating too quickly',
      'Mixing two gluten-free foods',
      'Gluten transferring to gluten-free food',
      'Freezing food for too long',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Cross-contamination happens when gluten gets into gluten-free '
        'food, for example through crumbs on shared equipment.',
    category: 'Food Safety',
  ),
  QuizQuestion(
    id: 'q5',
    question: 'Which grain should someone with coeliac disease avoid '
        'unless it is specifically labelled gluten-free?',
    options: [
      'Barley',
      'Rice',
      'Corn',
      'Quinoa',
    ],
    correctAnswerIndex: 0,
    explanation:
        'Barley contains gluten. Choose suitable gluten-free alternatives '
        'and check product labels.',
    category: 'Gluten Basics',
  ),
];
