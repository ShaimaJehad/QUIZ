import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text('QUIZ'),
          ),
        ),
        // backgroundColor: Colors.grey.shade900,
        //backgroundColor: Colors.grey,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Brain quizBrain = Brain();
  List<Icon> checks = [];
  void checkAnswer(bool userChoice) {
    bool correctanswer = quizBrain.getQuestionanswer();
    setState(() {
      if (correctanswer == userChoice) {
        checks.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        checks.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      if (quizBrain.isFinished()) {
        // ignore: avoid_print
        print('Quiz finish');
        Timer(const Duration(seconds: 1), () {
          Alert(context: context, title: "Finsihed", desc: "you are done.")
              .show();
          setState(() {
            quizBrain.reset();
            checks.clear();
          });
        });
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                child: const Text(
                  'Ture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
                child: const Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            children: checks,
          ),
        ],
      ),
    );
  }
}
