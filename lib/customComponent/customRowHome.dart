// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customrowhome extends StatelessWidget {
  const Customrowhome(
      {super.key, required this.ImageHome, required this.textImage});

  final String ImageHome;
  final String textImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(
            ImageHome,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textImage,
                textAlign: TextAlign.center,
                softWrap: true,
                style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.w),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
