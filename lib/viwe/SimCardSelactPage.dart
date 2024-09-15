import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goaraa_app_eg1/main.dart';
import 'package:goaraa_app_eg1/viwe/ProfileDialog.dart';
import '../controller/SimInfoController.dart';
import '../customComponent/customButoom.dart';
import '../customComponent/customLoading.dart';

class SimCardSelectPage extends StatelessWidget {
  const SimCardSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SimCardController controller = Get.put(SimCardController());

    RxInt selectedSimIndex = (-1).obs; // تخزين الشريحة المختارة

    return Scaffold(
      appBar: AppBar(
     
      ),
      body: Column(
        children: [
           Text(
            "Welcometo".tr,
            style: const TextStyle(fontSize: 20),
          ),
          Image.asset(
            "assets/AppName.png",
            height: 50,
            width: 200,
            fit: BoxFit.cover,
          ),
           Expanded(
            flex: 2,
            child: Text(
              "numbercontinue".tr,
              style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            if (controller.simCards.isEmpty) {
              return const Center(child: CustomLoading());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: controller.simCards.map((info) {
                  int index = controller.simCards.indexOf(info);
                  return GestureDetector(
                    onTap: () {
                      selectedSimIndex.value = index; // تحديث الشريحة المختارة
                    },
                    child: Obx(() {
                      return Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedSimIndex.value == index
                                ? Colors.deepOrangeAccent
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 251, 187, 152),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.simCard,
                                    size: 38,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                              Text('SIM ${int.parse(info.slotIndex) + 1}'),
                              Text(info.carrierName),
                              Text(info.number.isNotEmpty
                                  ? info.number
                                  : "availablenumber".tr),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
            );
          }),
          const SizedBox(height: 20),
           Text(
           "Notethat".tr,
            style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
           Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 8, left: 8),
              child: Text(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
            "PleaseSIM".tr
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: CustomButton(
              onPressed: () async {
                print(selectedSimIndex.value);
             
                if (selectedSimIndex.value != -1) {
                  // الحصول على رقم الهاتف من الشريحة المختارة
                  String selectedPhoneNumber =
                      controller.simCards[selectedSimIndex.value].number;
                  
                  // التأكد من وجود رقم الهاتف
                  if (selectedPhoneNumber.isEmpty) {
                    Get.snackbar("error".tr,
                        "SelectedSIM".tr);
                    return; // الخروج من الدالة إذا لم يكن الرقم متاحاً
                  }

                  // تخزين المستخدم المختار
                  sharedPreferences!.setString("mobileNumber", selectedPhoneNumber);
                  sharedPreferences!.setString("id", "user");
                  
                  // الانتقال إلى الصفحة التالية
                  Get.offAll(() => const ProfileView());
                }
                 else {
                  Get.snackbar("error".tr, "PleaseSIM".tr);
                }
              },
              ButtonColor: Colors.deepPurple,
              ButtonString:  Text(
                "next".tr,
                style:const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*name: goaraa_app_eg1
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.5.1

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  get: ^4.6.6
  concentric_transition: ^1.0.3
  responsive_builder: ^0.7.1
  font_awesome_flutter: ^10.7.0
  intl_phone_field: ^3.2.0
  pin_code_fields: ^8.0.1
  awesome_dialog: ^3.2.1
  firebase_auth: ^5.2.0
  google_sign_in: ^6.2.1
  flutter_facebook_auth: ^7.0.1
  twitter_login: ^4.4.2
  carousel_slider: ^5.0.0
  smooth_page_indicator: ^1.2.0+3
  salomon_bottom_bar: ^3.3.2
  firebase_core: ^3.4.0
  firebase_auth_web: ^5.8.0
  permission_handler: ^11.3.1
  cloud_firestore: ^5.4.0
  shared_preferences: ^2.3.2
  image_picker: ^1.1.2
  firebase_storage: ^12.2.0
  fetch_mobile_numbers: ^0.0.1
  lottie: ^3.1.2
  geolocator: ^13.0.1
  flutter_plugin_openwhatsapp: ^0.0.2
  firebase_app_check: ^0.3.1
  uuid: ^4.5.0
  supabase_flutter: ^2.6.0
  http: ^1.2.2
  url_launcher: ^6.3.0
  flutter_onboarding_slider: ^1.0.11
  flutter_screenutil: ^5.9.3
  connectivity_plus: ^6.0.5


  

dev_dependencies:
  flutter_lints: ^4.0.0
  flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: true
  ios: true
  image_path: "assets/ic_logo_border.png" 


  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^4.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:
    - assets/
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
*/