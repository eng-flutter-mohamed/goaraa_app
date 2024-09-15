import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_openwhatsapp/flutter_plugin_openwhatsapp.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/bindings/bindingApp.dart';
import 'package:goaraa_app_eg1/customComponent/customLoading.dart';
import 'package:goaraa_app_eg1/main.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controller/ProfileController.dart';
import 'package:goaraa_app_eg1/customComponent/CustomColumn.dart';

import 'package:goaraa_app_eg1/customComponent/CustomLogo.dart';
import 'package:goaraa_app_eg1/viwe/startpage.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthtScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 146, 73, 249),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double padding =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile
                  ? 16.0
                  : 100.0;

          return Obx(() {
            return ListView(
              children: [
                CustomLogo(
                  heightCustom: heightScreen / 4,
                  paddingVal: padding,
                  child: Customcolumn(
                    logoImage: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: controller.isLoading.value
                              ?const Center(child: CustomLoading())
                              : controller.userImage.value.isNotEmpty
                                  ? Image.network(
                                      height: heightScreen / 6,
                                      width: widthtScreen / 2.5,
                                      controller.userImage.value,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          height: heightScreen / 6,
                                          width: widthtScreen / 2.5,
                                          "assets/DoctorPhoto.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      height: heightScreen / 6,
                                      width: widthtScreen / 2.5,
                                      'assets/DoctorPhoto.png',
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: controller.pickImage,
                          ),
                        ),
                      ],
                    ),
                    paddingVal: padding,
                    CustCross: CrossAxisAlignment.center,
                    CustMain: MainAxisAlignment.center,
                    flex: 5,
                    chaled: Obx(
                      () => Text(
                        controller.userName.value, // عرض اسم المستخدم هنا
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.deepPurpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1.5)),
                              leading: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              title: Text(
                                controller.userEmail.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen / 60,
                          ),
                          Card(
                            child: ListTile(
                              onTap: () async {
                                final flutterPlugin =
                                    FlutterPluginOpenwhatsapp();
                                var platform = defaultTargetPlatform;
                                if (platform == TargetPlatform.android) {
                                  String? result =
                                      await flutterPlugin.openWhatsApp(
                                    phoneNumber: '+20244611809',
                                    text: 'Hi'.tr,
                                  );
                                  debugPrint('>>>: $result');
                                }
                              },
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1.5)),
                              title: Center(
                                child: Text(
                                  "callـsuport".tr,
                                  style: const TextStyle(
                                     fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen / 60,
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                            controller.changeLocale();
                              },
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1.5)),
                              title: Center(
                                child: Text(
                                  "switch_language".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen / 60,
                          ),
                          Card(
                            child: ListTile(
                              onTap: () async {
                                await Supabase.instance.client.auth.signOut();
                                await FirebaseAuth.instance.signOut();
                                sharedPreferences!.clear();
                                Get.offAll(() => const WelcomPage(),
                                    binding: AuthBinding());
                              },
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1.5)),
                              title: Center(
                                child: Text(
                                  "outt".tr,
                                  style: const TextStyle(
                                     fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
