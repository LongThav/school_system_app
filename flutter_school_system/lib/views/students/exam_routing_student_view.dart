import 'package:flutter/material.dart';

class ExamRoutinViewStudent extends StatefulWidget {
  const ExamRoutinViewStudent({super.key});

  @override
  State<ExamRoutinViewStudent> createState() => _ExamRoutinViewStudentState();
}

class _ExamRoutinViewStudentState extends State<ExamRoutinViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Routine"),
      ),
    );
  }
}