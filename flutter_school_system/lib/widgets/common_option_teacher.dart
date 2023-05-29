import 'package:flutter/material.dart';

import '../constants/color.dart';

class CommonOptionTeacher extends StatelessWidget {
  final DecorationImage image;
  final String title;
  const CommonOptionTeacher(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
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

class CommonLogout extends StatelessWidget {
  final String title;
  final Icon icon;
  const CommonLogout(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
          ),
          child: icon,
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

