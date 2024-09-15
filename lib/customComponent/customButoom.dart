import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color ButtonColor;
   final Widget ButtonString;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.ButtonColor,
    required this.ButtonString,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Color.fromARGB(255, 146, 73, 249),
          )),
      color: ButtonColor,
      onPressed: onPressed,
      child: SizedBox(
          width: double.infinity,
          height: heightScreen / 3 / 4.5,
          child: Center(
            child: ButtonString,
          )),
    );
  }
}
