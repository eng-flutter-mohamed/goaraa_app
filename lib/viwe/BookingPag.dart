// ignore_for_file: must_be_immutable, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goaraa_app_eg1/controller/ProfileController.dart';
import 'package:goaraa_app_eg1/customComponent/CustomColumn.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import 'package:goaraa_app_eg1/model/service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controller/BookingController.dart';
import '../controller/SimInfoController.dart';

import '../customComponent/CustomLogo.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key, required this.selectedServices});

  final BookingController controller = Get.put(BookingController());
  SimCardController simCardController = Get.put(SimCardController());
  ProfileController profileController = Get.put(ProfileController());
  final List<Service> selectedServices; // استرجع أو حدد الخدمات المختارة هنا

  Future<void> _addBooking(BuildContext context) async {
    print(
        'Selected services: $selectedServices'); // لطباعة الخدمات والتحقق منها

    final permissionStatus = await Permission.location.request();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (permissionStatus.isGranted && serviceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await controller.addBooking(simCardController, selectedServices);
    } else {
     Get.snackbar('Permission Denied', 'مطلوب إذن الموقع');
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 146, 73, 249),
      ),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        double padding =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 16.0
                  : 100.0;
        return Stack(
          children: [
            CustomLogo(
              paddingVal: heightScreen / 8 / 8 / 4,
              heightCustom: heightScreen / 3.7,
              child: Customcolumn(
                flex: 7,
                logoImage: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    "assets/ic_logo_border.png",
                    height: heightScreen / 2.9 / 2,
                    width: widthScreen / 2 / 1.2,
                    fit: BoxFit.cover,
                  ),
                ),
                paddingVal: padding,
         
               
                CustCross: CrossAxisAlignment.start,
                CustMain: MainAxisAlignment.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: heightScreen / 5, right: padding, left: padding),
              child: SizedBox(
                height: heightScreen / 1.8,
                child: Card(
                  child: Form(
                    key: controller.formKey.value,
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: Colors.deepPurpleAccent,
                                    width: 1.2,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    profileController.userName.value,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: heightScreen * 0.02),
                            Obx(() => TextFormField(
  onTap: () => controller.showGenderDialog(context),
  key: const Key('genderField'),
  controller: controller.genderController.value,
  readOnly: true,
  decoration: InputDecoration(
    labelText: 'Type'.tr,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
  ),
))
,
                              SizedBox(height: heightScreen * 0.02),
                              TextFormField(
                                key: const Key('chronicDiseasesField'),
                                controller:
                                    controller.chronicDiseasesController.value,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: 'chronicDiseases'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "pleasechronicDiseases".tr;
                               
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: heightScreen * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => SizedBox(
                                        width: widthScreen / 2.6,
                                        child: TextFormField(
                                          key: const Key('dateField'),
                                          controller: controller
                                              .selectedDateController.value,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "date".tr,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          onTap: () async {
                                            await controller
                                                .selectDate(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'pleaseDate'.tr;
                                            }
                                            return null;
                                          },
                                        ),
                                      )),
                                  Obx(() => SizedBox(
                                        width: widthScreen / 2.6,
                                        child: TextFormField(
                                          key: const Key('timeField'),
                                          controller: controller
                                              .selectedTimeController.value,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'Time'.tr,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.timelapse,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          onTap: () async {
                                            await controller
                                                .selectTime(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'pleaseTime'.tr;
                                            }
                                            return null;
                                          },
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: heightScreen * 0.02),
                              CustomButton(
                                onPressed: () async {
                                  if (controller.formKey.value.currentState!
                                      .validate()) {
                                    if (!controller.loading.value) {
                                      controller.checkUserMobileNumber(
                                          simCardController, selectedServices);
                                    } else {
                                      await _addBooking(
                                          context); // Ensure selectedServices is passed
                                    }
                                  } else {
                                   Get.snackbar('error'.tr, 'PleaseCheck'.tr);
                                  }
                                },
                                ButtonColor: Colors.white,
                                ButtonString: Obx(() => controller.loading.value
                                    ? CustomLoading()
                                    : Text(
                                       "confirmreservation".tr,
                                        style: const TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 16),
                                      )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
