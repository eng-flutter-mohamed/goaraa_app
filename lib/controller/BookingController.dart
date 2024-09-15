// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:goaraa_app_eg1/model/service.dart';
import 'package:goaraa_app_eg1/controller/SimInfoController.dart';

import '../main.dart';

class BookingController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  var genderController = TextEditingController().obs;
  var chronicDiseasesController = TextEditingController().obs;
  var selectedDateController = TextEditingController().obs;
  var selectedTimeController = TextEditingController().obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var userAddress = ''.obs;
  var loading = false.obs;

  final supabase = Supabase.instance.client;
  final String bookingTable = 'BookingServices';

  Future<void> checkUserMobileNumber(SimCardController simCardController,
      List<Service> selectedServices) async {
    final uid = sharedPreferences!.getString("userId") ?? "";
    loading.value = true;

    final response =
        await supabase.from('users').select().eq('id', uid).single();
    final userData = response;
    final mobileNumber = userData['mobileNumber'];

    if (mobileNumber == null || mobileNumber.isEmpty) {
      // إذا لم يكن هناك رقم هاتف، عرض مربع حوار لاختيار رقم الهاتف
      Get.defaultDialog(
        title: "numbercontinue".tr,
        content: Obx(() {
          if (simCardController.simCards.isEmpty) {
            return const Text("لا توجد شرائح SIM متاحة");
          } else {
            return Column(
              children: simCardController.simCards.map((simCard) {
                return ListTile(
                  title: Text(simCard.number),
                  onTap: () async {
                    final updateResponse = await supabase
                        .from('users')
                        .update({'mobileNumber': simCard.number}).eq('id', uid);

                    Get.back();
                    // بعد اختيار رقم الهاتف، قم بإضافة الحجز
                    await addBooking(simCardController,
                        selectedServices); // هنا تمرير selectedServices بشكل صحيح
                  },
                );
              }).toList(),
            );
          }
        }),
        barrierDismissible: false,
      );
    } else {
      // إذا كان هناك رقم هاتف، قم بإضافة الحجز مباشرةً
      await addBooking(simCardController,
          selectedServices); // هنا تمرير selectedServices بشكل صحيح
    }

    loading.value = false;
    loading.value = true;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      selectedDateController.value.text = formatDate(pickedDate);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
      selectedTimeController.value.text = pickedTime.format(context).toString();
    }
  }

  void showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('ChooseType'.tr),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Get.back(result: 'male');
              },
              child: Text('male'.tr),
            ),
            SimpleDialogOption(
              onPressed: () {
                Get.back(result: 'female');
              },
              child: Text('female'.tr),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        // تأكد من أنك تعين القيمة بشكل صحيح هنا
        genderController.value.text = value;
      }
    });
  }

  Future<void> addBooking(SimCardController simCardController,
      List<Service> selectedServices) async {
    loading.value = true;

    try {
      String? userId = sharedPreferences!.getString("userId");
      if (userId == null) {
        loading.value = false;
        return;
      }

      final permissionStatus = await Permission.location.request();
      if (!permissionStatus.isGranted) {
        Get.snackbar('PermissionDenied'.tr, "Location".tr);
        loading.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("selectedServices is tow $selectedServices");
      double totalPrice =
          selectedServices.fold(0, (sum, service) => sum + service.price);

      final response = await supabase
          .from('users')
          .select('nameUser, mobileNumber')
          .eq('id', userId)
          .single();
      String userName = response['nameUser'];
      String phoneNumber = response['mobileNumber'];
      print("selectedServices is three $selectedServices");
      final bookingResponse = await supabase.from('BookingServices').insert([
        {
          'userId': userId,
          'userName': userName,
          'phoneNumber': phoneNumber,
          'appointmentDate': selectedDateController.value.text,
          'appointmentTime': selectedTimeController.value.text,
          'location_lat': position.latitude.toString(),
          'location_lon': position.longitude.toString(),
          'Symptoms': chronicDiseasesController.value.text,
          'selectedServices': selectedServices.isNotEmpty
              ? selectedServices.map((service) => service.toMap()).toList()
              : [],
          'price': totalPrice,
          'status': 'تحت المراجعة',
          'createdAt': DateTime.now().toIso8601String(),
        }
      ]);
      print("selectedServices is one $selectedServices");
      Get.defaultDialog(
        title: "Booked".tr,
        content: const Text(""),
        confirm: ElevatedButton(
          onPressed: () => Get.offAllNamed("/home"),
          child: Text("reservationsuccessfully".tr),
        ),
        barrierDismissible: true,
        onWillPop: () {
          Get.offAllNamed("/home");
          return Future.value(false);
        },
      );
    } catch (e) {
      Get.snackbar('error'.tr, 'Failedload'.tr);
    } finally {
      loading.value = false;
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
