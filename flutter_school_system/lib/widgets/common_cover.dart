import 'package:flutter/material.dart';
import 'package:project/constants/logo.dart';

import '../constants/color.dart';

class CommonCover extends StatefulWidget {
  const CommonCover({super.key});

  @override
  State<CommonCover> createState() => _CommonCoverState();
}

class _CommonCoverState extends State<CommonCover> {
  @override
  Widget build(BuildContext context) {
     final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: -420,
          child: Container(
            width: width,
            height: height ,
            decoration: const BoxDecoration(
              color: green,
              shape: BoxShape.circle
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.478,
          left: width * 0.25,
          child: Container(
            width: width * 0.5,
            height: height * 0.5,
            decoration: const BoxDecoration(
              color: green,
              shape: BoxShape.circle
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(logoII),
                )
              ),
            ),
          ),
        )
      ],
    );
  }

}
