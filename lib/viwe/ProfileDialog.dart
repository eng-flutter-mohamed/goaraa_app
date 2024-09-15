import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/controller/ProfileController.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';

import 'package:responsive_builder/responsive_builder.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
                    "profile".tr,
                    style: const TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
      ),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        // ignore: unused_local_variable
        double padding =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? 16.0
                  : 100.0;

        return Obx(() {
          return ListView(
            children: [
              Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 1.2,
                      ),
                    ),
                    child: SizedBox(
                      height: heightScreen / 3,
                      width: double.infinity,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: controller.isLoading.value
                              ? const Center(child: CustomLoading())
                              : controller.userImage.value.isNotEmpty
                                  ? Image.network(
                                      controller.userImage.value,
                                      width: widthScreen / 2.6,
                                      height: heightScreen / 3 / 1.9,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          "assets/DoctorPhoto.png",
                                          width: widthScreen / 2.6,
                                          height: heightScreen / 3 / 1.9,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/DoctorPhoto.png',
                                      width: widthScreen / 2.6,
                                      height: heightScreen / 3 / 1.9,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: widthScreen / 3,
                    top: heightScreen / 3 / 4,
                    child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          controller.pickImage();
                        }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.deepPurpleAccent,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 1.2,
                        )),
                    labelText: 'enterName'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 1.2,
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: heightScreen / 3, right: 80, left: 80),
                child: CustomButton(
                  onPressed: () async {
                    if (controller.nameController.text.trim().isEmpty) {
                     Get.snackbar("error".tr, "Please enter your name");
                    } else {
                      await controller.saveProfile();
                    }
                  },
                  ButtonColor: Colors.white,
                  ButtonString: Text(
                    "next".tr,
                    style: const TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          );
        });
      }),
    );
  }
}
