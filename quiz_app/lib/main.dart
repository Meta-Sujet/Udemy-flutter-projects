import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';

import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Dino', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite number?',
      'answers': [
        {'text': 'One', 'score': 10},
        {'text': 'Two', 'score': 5},
        {'text': 'Three', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  var _score = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _score = score;
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    log(_questionIndex.toString());

    // if (_questionIndex < _questions.length) {
    //   log('We have more questions');
    // } else {
    //   log('No more questions');
    // }
  }

  void previousQuestion() {
    if (_questionIndex <= 0 || _questionIndex >= _questions.length) {
      return;
    }
    setState(() {
      _questionIndex -= 1;
      _totalScore -= _score;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('total: $_totalScore');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed:
                    _questionIndex <= 0 || _questionIndex >= _questions.length
                        ? null
                        : previousQuestion,
                icon: const Icon(
                  Icons.arrow_left,
                  size: 50,
                ),
              ),
            )
          ],
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questionIndex: _questionIndex,
                answerQuestion: _answerQuestion,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
