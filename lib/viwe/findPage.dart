import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/FindColtroller.dart';
import '../customComponent/CustomAppBar.dart';
import '../customComponent/CustomColumn.dart';
import '../customComponent/CustomLogo.dart';
import '../customComponent/customButoom.dart';
import '../customComponent/customTextForm.dart';

class FindPage extends StatelessWidget {
  const FindPage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    FindController findController = Get.put(FindController());

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
              paddingVal: heightScreen / 8 / 8 / 8,
              heightCustom: heightScreen / 4.2,
              child: Customcolumn(
                flex: 2,
                paddingVal: padding,
                chaled: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find_account".tr,
                      style: TextStyle(
                          fontSize: heightScreen / 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                CustCross: CrossAxisAlignment.start,
                CustMain: MainAxisAlignment.start,
              ),
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
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
                            Customtextform(
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              textInputType: TextInputType.emailAddress,
                              iconText: const FaIcon(
                                FontAwesomeIcons.envelope,
                                color: Color.fromARGB(255, 146, 73, 249),
                              ),
                              textform: "  Email",
                              controller: findController.emailController,
                            ),
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
                            CustomButton(
                              onPressed: () async {
                                // Optionally show a loading indicator
                                await findController.verifyEmail();
                              },
                              ButtonColor: const Color.fromARGB(255, 146, 73, 249),
                              ButtonString: const Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
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

// دالة لإرسال البريد الإلكتروني لإعادة تعيين كلمة المرور
Future<void> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Get.snackbar(
      'Success',
      'Password reset email has been sent to $email',
      snackPosition: SnackPosition.TOP,
    );
    Get.offAllNamed("/SignInPage");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.snackbar(
        'Error',
        'No user found for that email.',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.message}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
