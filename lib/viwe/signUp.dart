import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/CustomAppBar.dart';
import 'package:goaraa_app_eg1/customComponent/CustomDivider.dart';
import 'package:goaraa_app_eg1/customComponent/CustomRowCard.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import 'package:goaraa_app_eg1/customComponent/customTextForm.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/signUpController.dart';
import '../customComponent/CustomColumn.dart';
import '../customComponent/CustomLogo.dart';
import '../customComponent/customButoom.dart';
import 'TermsOfService.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    SignUpController signUpController = Get.put(SignUpController());

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
                flex: 0,
                paddingVal: padding,
                chaled: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "welcome_message".tr,
                      style: TextStyle(
                          fontSize: heightScreen / 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'sign_up_D'.tr,
                      style: TextStyle(
                          fontSize: heightScreen / 45, color: Colors.white),
                    )
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
                            Form(
                              key: signUpController.formKey,
                              child: Column(
                                children: [
                                  Customtextform(
                                      textInputType: TextInputType.name,
                                      controller: signUpController.name,
                                      iconText: const FaIcon(
                                        FontAwesomeIcons.person,
                                        color:
                                            Color.fromARGB(255, 146, 73, 249),
                                      ),
                                      textform: "Full_Name".tr),
                                  SizedBox(
                                    height: heightScreen / 3 / 7 / 3,
                                  ),
                                  Customtextform(
                                      textInputType: TextInputType.emailAddress,
                                      controller: signUpController.email,
                                      iconText: const FaIcon(
                                        FontAwesomeIcons.envelope,
                                        color:
                                            Color.fromARGB(255, 146, 73, 249),
                                      ),
                                      textform: "email".tr),
                                  SizedBox(
                                    height: heightScreen / 3 / 7 / 3,
                                  ),
                                  Customtextform(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller: signUpController.password,
                                      iconText: const FaIcon(
                                        FontAwesomeIcons.lock,
                                        color:
                                            Color.fromARGB(255, 146, 73, 249),
                                      ),
                                      textform: "password".tr),
                                  SizedBox(
                                    height: heightScreen / 3 / 7 / 3,
                                  ),
                                ],
                              ),
                            ),
                            CustomButton(
                              onPressed: () {
                                Obx(() => signUpController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : Container());

                                signUpController.newUser();
                              },
                              ButtonColor:
                                  const Color.fromARGB(255, 146, 73, 249),
                              ButtonString:
                                  // في المكان الذي ترغب بعرض حالة التحميل فيه
                                  Obx(() {
                                return signUpController.isLoading.value
                                    ? const CustomLoading()
                                    : Text(
                                        'sign_up'.tr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ); // أو أي عنصر آخر لعرضه عند انتهاء التحميل
                              }),
                            ),
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "signing"
                                    .tr, //".   "signing":  "By signing up you accept our ",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Terms"
                                        .tr, //"Terms":"Terms of Services ",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 146, 73, 249),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                       Get.to(()=>const TermsOfServicePage());//Terms of Services tapped
                                      },
                                  ),
                                  TextSpan(text: "and".tr), //"and":"and",
                                  TextSpan(
                                    text: "Privacy"
                                        .tr, //"Privacy": "Privacy" Policy,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 146, 73, 249),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                       Get.to(()=>const TermsOfServicePage());
                                      },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen / 40,
                    ),
                    Customdivider(
                      padding: padding,
                    ),
                    SizedBox(
                      height: heightScreen / 40,
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
                      height: heightScreen / 3 / 4 / 3,
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
