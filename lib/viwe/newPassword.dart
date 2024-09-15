import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/CustomAppBar.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';
import 'package:goaraa_app_eg1/viwe/SuccsesfullyChange.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/signUpController.dart';
import '../customComponent/CustomColumn.dart';
import '../customComponent/CustomLogo.dart';
import '../customComponent/customTextForm.dart';

class Newpassword extends StatelessWidget {
  const Newpassword({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    SignUpController authController = SignUpController();
    return Scaffold(
      appBar:const CustomAppBar(),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double padding =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 16.0
                  : 100.0;

          return Stack(children: [
             CustomLogo(
              paddingVal: heightScreen/8/8/8,
              heightCustom: heightScreen / 4.2,
              child: Customcolumn(
                    flex: 5,
                paddingVal: padding,
                title: "Create new password".tr,
                subTitle:
                    "Create a new password and please never share it with anyone for safe use."
                          .tr,
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
                             Customtextform(
                              textInputType: TextInputType.visiblePassword,
                              iconText: const FaIcon(
                                FontAwesomeIcons.lock,
                                color: Color.fromARGB(255, 146, 73, 249),
                              ),
                              textform: "  New Password",
                              controller: authController.password,
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
                              textform: "  Confirm New Password",
                              controller: authController.password,
                            ),
                           
                            SizedBox(
                              height: heightScreen / 3 / 7 / 3,
                            ),
                       CustomButton(onPressed: (){Get.offAll(()=>const Succsesfullychange());}, ButtonColor:  const Color.fromARGB(255, 146, 73, 249), ButtonString: const Text(
                                    'Update Password',
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
