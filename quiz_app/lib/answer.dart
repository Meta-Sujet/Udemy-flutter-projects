import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(this.answerText, this.selectHandler, {Key? key})
      : super(key: key);

  final VoidCallback selectHandler;
  final String answerText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
