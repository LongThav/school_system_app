import 'package:flutter/material.dart';

import '../constants/color.dart';

class ButtonClick extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final bool loading;
  const ButtonClick(
      {super.key,
      required this.title,
      required this.callback,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        width: width,
        height: height * 0.075,
        decoration: BoxDecoration(
          color: blueWithOpa,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
