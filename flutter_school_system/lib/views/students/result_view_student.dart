import 'package:flutter/material.dart';

import '../../constants/color.dart';
import 'first_terminal_view_student.dart';
import 'second_terminal_view.dart';

class ResultStudentView extends StatefulWidget {
  const ResultStudentView({super.key});

  @override
  State<ResultStudentView> createState() => _ResultStudentViewState();
}

class _ResultStudentViewState extends State<ResultStudentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Result".toUpperCase()),
        titleSpacing: -10,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FirstTerminalViewStudent();
                }));
              },
              child: _buildTerminal('First Terminal', 'View')),
          SizedBox(
            height: height * 0.1,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SecondTerminalViewStudent();
                }));
              },
              child: _buildTerminal('Second Terminal', 'View')),
        ],
      ),
    );
  }

  Widget _buildTerminal(String terminal, String status) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.25,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(1, 1),
            ),
            BoxShadow(color: Colors.grey, offset: Offset(1, 1)),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                terminal,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: blue),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: width,
              height: height * 0.08,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15, top: 15),
              alignment: Alignment.centerRight,
              child: Text(
                status.toUpperCase(),
                style: const TextStyle(fontSize: 18, color: blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
