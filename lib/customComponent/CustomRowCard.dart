// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import '../controller/AuthenticationController.dart';

// import '../viwe/login.dart';
AuthController socialAuthentication = Get.put(AuthController());

class RowCutom extends StatelessWidget {
  final double padding;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onFacebookSignIn;
  final VoidCallback onTwitterSignIn;
  const RowCutom(
      {super.key,
      required this.padding,
      required this.onGoogleSignIn,
      required this.onFacebookSignIn,
      required this.onTwitterSignIn});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding / 100),
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: socialAuthentication.isLoading.value?const CustomLoading():
                  const FaIcon(FontAwesomeIcons.facebook,
                      size: 50, color: Colors.blue),
                  onPressed: onFacebookSignIn),
              IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter,
                      size: 50, color: Colors.blue),
                  onPressed: onTwitterSignIn),
              IconButton(
                  icon: const FaIcon(FontAwesomeIcons.google,
                      size: 50, color: Colors.red),
                  onPressed: onGoogleSignIn),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.mobile,
                    size: 50, color: Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  if (Platform.isIOS) {
                    // إذا كان النظام iOS، الانتقال إلى صفحة تسجيل الدخول
                    Get.toNamed("/LoginPage");
                  } else if (Platform.isAndroid) {
                    // إذا كان النظام Android، الانتقال إلى صفحة اختيار الشريحة
                   Get.toNamed("/LoginPage");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
