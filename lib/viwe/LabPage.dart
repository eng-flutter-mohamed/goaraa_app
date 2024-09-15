import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ServiceIyimsController.dart';
import '../customComponent/customColumnCatigory.dart';

class Labpage extends StatelessWidget {
  const Labpage({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.put(ServiceController());

    // جلب البيانات عند تحميل الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchServices('Lab'); // استخدم الفئة المناسبة لجلب البيانات
    });

    return Scaffold(
      body: CustomColumnCategory(
        controller: controller,
        titlePage: 'lab'.tr,
      ),
    );
  }
}
