import 'package:flutter/material.dart';

class Customtextbutoom extends StatelessWidget {
  const Customtextbutoom({super.key, required this.TextButtonVal, required this.onPressed});

final VoidCallback onPressed;
final String TextButtonVal;
  @override
  Widget build(BuildContext context) {
   return   TextButton(onPressed: onPressed, child:  Text(TextButtonVal));
  }
  
}