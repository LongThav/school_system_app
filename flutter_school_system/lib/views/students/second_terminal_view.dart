import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/common_btn_create_user.dart';

import '../../constants/color.dart';

class SecondTerminalViewStudent extends StatefulWidget {
  const SecondTerminalViewStudent({super.key});

  @override
  State<SecondTerminalViewStudent> createState() =>
      _SecondTerminalViewStudentState();
}

class _SecondTerminalViewStudentState extends State<SecondTerminalViewStudent> {
  var dateTime = DateFormat.yMMMEd().format(DateTime.now());
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.06,
              color: Colors.blue[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Term: Second",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "Date: $dateTime",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "The standard Lorem Ipsum passage. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua? ",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child:
                  BtnCreateUser(title: 'Download your result', callback: () {}),
            )
          ],
        ),
      ),
    );
  }
}
