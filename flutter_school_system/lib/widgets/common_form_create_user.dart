import 'package:flutter/material.dart';

class CommonFormCreateuser extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final String hint;
  const CommonFormCreateuser(
      {super.key, required this.text, this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 15),
          width: width,
          height: height * 0.07,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}

class CommonFormViewStudent extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final String hint;
  const CommonFormViewStudent(
      {super.key, required this.text, this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 15),
          width: width,
          height: height * 0.07,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  hint,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                )),
          ),
        ),
      ],
    );
  }
}
