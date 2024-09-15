import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FindController extends GetxController {
  final emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  Future<void> verifyEmail() async {
    try {
      print('Checking email: ${emailController.text}');
      final signInMethods = await _auth.fetchSignInMethodsForEmail(emailController.text);
      if (signInMethods.isNotEmpty) {
        Get.snackbar('Email Check', 'The email is already registered.');
      } else {
        Get.snackbar('Email Check', 'The email is not registered.');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.message}');
    }
  }
}
