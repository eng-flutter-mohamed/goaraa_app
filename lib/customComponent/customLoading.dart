import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/loading_animation.json', // المسار إلى ملف JSON الخاص بالتحميل
       
        fit: BoxFit.cover,
      ),
    );
  }
}
