import 'package:flutter/material.dart';

import '../constants/color.dart';

class CommonUser extends StatelessWidget {
  final DecorationImage image;
  final String title;
  const CommonUser({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: width * 0.2,
          height: height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: blueWithOpa,
              image: image),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
