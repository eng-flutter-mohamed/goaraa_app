import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/CustomLogo.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/viwe/signin.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../customComponent/CustomAppBar.dart';

//import '../controller/signUpController.dart';

class Succsesfullychange extends StatelessWidget {
  const Succsesfullychange({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthtScrin = MediaQuery.of(context).size.width;
    //  SignUpController authController = SignUpController();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double padding =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 16.0
                  : 100.0;

          return Stack(children: [
            CustomLogo(
              paddingVal: heightScreen/8/8/8,
              heightCustom: heightScreen / 4.5,
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: SizedBox(
                height: double.infinity,
                child: ListView(
                  children: [
                    Card(
                      margin: EdgeInsets.only(
                        top: heightScreen / 7,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          children: [
                            Text(
                              "Password Changed".tr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 146, 73, 249)),
                            ),
                            Center(
                              child: Text(
                                "Congratulationd!! You`ve successfully\nchanged your password"
                                    .tr,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
                            SizedBox(
                              height: heightScreen / 2 / 1.5,
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 73, 249),
                                radius: widthtScrin / 2 / 2,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: widthtScrin / 3 / 2,
                                ),
                              ),
                            ),
                            CustomButton(
                                onPressed: () {
                                  Get.offAll(() => const SignInPage());
                                },
                                ButtonColor:
                                    const Color.fromARGB(255, 146, 73, 249),
                                ButtonString: const Text(
                                  'Back to login',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
