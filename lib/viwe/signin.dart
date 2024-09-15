import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/CustomAppBar.dart';
import 'package:goaraa_app_eg1/customComponent/CustomColumn.dart';
import 'package:goaraa_app_eg1/customComponent/CustomDivider.dart';
import 'package:goaraa_app_eg1/customComponent/CustomLogo.dart';
import 'package:goaraa_app_eg1/customComponent/CustomRowCard.dart';
import 'package:goaraa_app_eg1/customComponent/CustomtextButoom.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import 'package:goaraa_app_eg1/customComponent/customTextForm.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/AuthenticationController.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    AuthController signinController = Get.put(AuthController());
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
           double padding;

          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            padding = 16.0;
          } else if (sizingInformation.deviceScreenType ==
              DeviceScreenType.tablet) {
            padding = 120.0;
          } else if (sizingInformation.deviceScreenType ==
              DeviceScreenType.desktop) {
            padding = 125.0;
          } else if (sizingInformation.deviceScreenType ==
              DeviceScreenType.watch) {
            padding = 8.0;
          } else {
            // قيمة افتراضية في حالة عدم تطابق أي نوع من الشاشات
            padding = 20.0;
          }

          return Stack(children: [
            CustomLogo(
              paddingVal: heightScreen / 8 / 8 / 8.w,
              heightCustom: heightScreen / 4.2.h,
              child: Customcolumn(
                flex: 0,
                paddingVal: padding,
                chaled: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WelcomBack".tr,
                      style: TextStyle(
                          fontSize: heightScreen / 35.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "sign_in_description".tr,
                      style: TextStyle(
                          fontSize: heightScreen / 48.h, color: Colors.white),
                    )
                  ],
                ),
                CustCross: CrossAxisAlignment.start,
                CustMain: MainAxisAlignment.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding/1.2.h),
              child: SizedBox(
                height: double.infinity,
                child: ListView(
                  children: [
                    Card(
                      margin: EdgeInsets.only(
                        top: heightScreen / 6.5.h,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: Form(
                          child: Column(
                            children: [
                              Customtextform(
                                textInputType: TextInputType.emailAddress,
                                iconText: const FaIcon(
                                  FontAwesomeIcons.envelope,
                                  color: Color.fromARGB(255, 146, 73, 249),
                                ),
                                textform: "email".tr,
                                controller: signinController.emailController,
                              ),
                              SizedBox(
                                height: heightScreen / 3 / 7 / 3,
                              ),
                              Customtextform(
                                textInputType: TextInputType.visiblePassword,
                                iconText: const FaIcon(
                                  FontAwesomeIcons.lock,
                                  color: Color.fromARGB(255, 146, 73, 249),
                                ),
                                textform: "password".tr,
                                controller: signinController.passwordController,
                              ),
                              SizedBox(
                                height: heightScreen / 3 / 7 / 3,
                              ),
                              CustomButton(
                                onPressed: () {
                                  signinController
                                      .signInWithEmail(); // استدعاء دالة تسجيل الدخول
                                },
                                ButtonColor:
                                    const Color.fromARGB(255, 146, 73, 249),
                                ButtonString: Obx(
                                  () => signinController.isLoading.value
                                      ? const CustomLoading() // عرض مؤشر التحميل عند تسجيل الدخول
                                      : Text(
                                          'sign_in'.tr,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                              Customtextbutoom(
                                TextButtonVal: 'forgot_password'.tr,
                                onPressed: () {
                                  Get.toNamed("Find");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen / 20,
                    ),
                    Customdivider(
                      padding: padding,
                    ),
                    SizedBox(
                      height: heightScreen / 30,
                    ),
                    RowCutom(
                      padding: padding / 4,
                      onGoogleSignIn: () {
                        socialAuthentication.signInWithGoogle();
                      },
                      onFacebookSignIn: () {
                        socialAuthentication.signInWithFacebook();
                      },
                      onTwitterSignIn: () {
                        socialAuthentication.signInWithTwitter();
                      },
                    ),
                    SizedBox(
                      height: heightScreen / 3 / 3 / 3,
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
