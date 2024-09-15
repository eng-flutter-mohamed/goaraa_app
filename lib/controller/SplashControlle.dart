import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viwe/SplashScreenPage.dart';
import '../viwe/startpage.dart';

class SplashController extends GetxController {
  // قائمة الصفحات
  final RxList<PageData> pages = <PageData>[
    const PageData(
      image: 'assets/WelcomD.png',
      bgColor: Color(0xffb088f9),
    ),
    const PageData(
      image: 'assets/welcomN.png',
      bgColor: Color(0xFF6354ed),
    ),
    const PageData(
      image: 'assets/WelcomPh.png',
      bgColor: Colors.deepPurple,
    ),
  ].obs;

  // المتغير الذي يتتبع الفهرس الحالي
  final RxInt currentIndex = 0.obs;

  // تحديث الفهرس الحالي عند تغيير الصفحة
  void updateIndex(int index) {
    currentIndex.value = index;
  }

  // وظيفة تستدعي عند الانتهاء من الـ ConcentricPageView
  void onFinish() {
    Get.offAll(const WelcomPage());
  }
}
