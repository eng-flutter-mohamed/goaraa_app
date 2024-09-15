// ignore_for_file: unnecessary_null_comparison
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viwe/BookingPag.dart';
class InvoiceController extends GetxController {
  final String serviceName;
  final num total;
  final List<double> price2;

  InvoiceController({
    required this.serviceName,
    required this.total,
    required this.price2,
  });

  void showErrorDialog(BuildContext context, String title, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  void confirmBooking(BuildContext context, myData) {
    if (myData.nameUser == null) {
      showErrorDialog(context, "خطاء في التجسل", "عليك التسجيل");
    } else {
      Get.to(BookingPage(selectedServices: [],));
    }
  }
}
