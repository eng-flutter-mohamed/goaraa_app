// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/main.dart';
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    sharedPreferences!.getString("id");
    // final userId = FirebaseAuth.instance.currentUser?.uid;
    print("========================${sharedPreferences!.getString("id")}");
    if (sharedPreferences!.getString("id") != null) {
      return const RouteSettings(name: "/home");
    }

    // تحقق من بيانات المستخدم في Firestore
    // يمكنك إضافة تحقق من Firestore هنا إذا لزم الأمر
    return null;
  }
}
