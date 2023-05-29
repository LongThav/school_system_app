import 'package:flutter/material.dart';

import '../../constants/color.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
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
          _buildTerminal('First Terminal', 'Publish'),
          SizedBox(
            height: height * 0.1,
          ),
          _buildTerminal('Second Terminal', 'Publish'),
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
            BoxShadow(
                color: Colors.black, offset: Offset(1, 1),),
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
