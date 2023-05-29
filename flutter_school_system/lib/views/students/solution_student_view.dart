import 'package:flutter/material.dart';

class SolutionViewStudent extends StatefulWidget {
  const SolutionViewStudent({super.key});

  @override
  State<SolutionViewStudent> createState() => _SolutionViewStudentState();
}

class _SolutionViewStudentState extends State<SolutionViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solution"),
      ),
    );
  }
}