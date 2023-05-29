import 'package:flutter/material.dart';

class QuizViewStudent extends StatefulWidget {
  const QuizViewStudent({super.key});

  @override
  State<QuizViewStudent> createState() => _QuizViewStudentState();
}

class _QuizViewStudentState extends State<QuizViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
    );
  }
}