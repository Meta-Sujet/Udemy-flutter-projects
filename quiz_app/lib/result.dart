import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(this.resultScore, this.resetQuiz, {Key? key}) : super(key: key);

  final int resultScore;
  final VoidCallback resetQuiz;

  String get resultPhrase {
    var resultText = 'You did it!';
    if (resultScore <= 8) {
      resultText = 'Awesome';
    } else if (resultScore <= 12) {
      resultText = 'Pretty likeable';
    } else if (resultScore <= 16) {
      resultText = 'Strange';
    } else {
      resultText = 'Bad';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            resultScore.toString(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: resetQuiz,
            child: const Text('Reset Quiz'),
          ),
        ],
      ),
    );
  }
}
