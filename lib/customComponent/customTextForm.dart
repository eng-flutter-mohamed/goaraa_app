// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/signUpController.dart';

class Customtextform extends StatelessWidget {
  Customtextform({
    super.key,
    required this.iconText,
    required this.textform,
    required this.controller,
    required this.textInputType,
    this.validate
  });
  final FaIcon iconText;
  final String textform;
String? Function(String?)?  validate;
final TextInputType textInputType;
  final TextEditingController controller;
  SignUpController signUpController = SignUpController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
        validator: validate,
        controller: controller,
        decoration: InputDecoration(

            label: Row(
              children: [
                iconText,
                Text(
                  textform,
                )
              ],
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));
  }
}
