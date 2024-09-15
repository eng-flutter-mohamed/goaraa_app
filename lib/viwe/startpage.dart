import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/controller/AuthenticationController.dart';
import 'package:goaraa_app_eg1/controller/SimInfoController.dart';
import 'package:goaraa_app_eg1/customComponent/CustomColumn.dart';
import 'package:goaraa_app_eg1/customComponent/CustomDivider.dart';
import 'package:goaraa_app_eg1/customComponent/CustomLogo.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:twitter_login/entity/auth_result.dart';
import '../customComponent/CustomRowCard.dart';

AuthController socialAuthentication = Get.put(AuthController());
SimCardController cardController = Get.find();

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Obx(()=> socialAuthentication.isLoading.value
        ? const Center(child: CustomLoading())
        : Scaffold(

            body: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                double padding;

                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile) {
                  padding = 16.0;
                } else if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.tablet) {
                  padding = 100.0;
                } else if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  padding = 100.0;
                } else if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.watch) {
                  padding = 8.0;
                } else {
                  // قيمة افتراضية في حالة عدم تطابق أي نوع من الشاشات
                  padding = 20.0;
                }

                return Stack(children: [
                  CustomLogo(
                    paddingVal: heightScreen / 8 / 8 / 8,
                    heightCustom: heightScreen / 2.5,
                    child: Customcolumn(
                      flex: 5,
                      paddingVal: padding,
                      CustMain: MainAxisAlignment.center,
                      CustCross: CrossAxisAlignment.center,
                      title: '',
                      subTitle: '',
                      logoImage: Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            "assets/ic_logo_border.png",
                            height: heightScreen / 2 / 2.5,
                            width: widthScreen / 2 / 1.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                              top: heightScreen / 4,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(padding),
                              child: Column(
                                children: [
                                  Text(
                                    "welcome_message".tr,
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "discover_amazing_things".tr,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightScreen / 3 / 3 / 3,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      Get.toNamed("SignInPage");
                                    },
                                    ButtonColor:
                                        const Color.fromARGB(255, 146, 73, 249),
                                    ButtonString: Text(
                                      'sign_in'.tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightScreen / 3 / 7 / 3,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      Get.toNamed("SignUpPage");
                                    },
                                    ButtonColor: Colors.white,
                                    ButtonString: Text(
                                      'sign_up'.tr,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 146, 73, 249),
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightScreen / 30,
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen / 2.9 / 2 / 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              },
            ),
          ))
   ;
  }
}

extension on Future<AuthResult> {
  get status => null;
}
