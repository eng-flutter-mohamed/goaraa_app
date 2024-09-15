import 'package:get/get.dart';
import 'package:goaraa_app_eg1/controller/ProfileController.dart';

import '../controller/AuthenticationController.dart';
import '../controller/SimInfoController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // هنا تقوم بإضافة كل الـ Controllers الذين تحتاجهم
    Get.put(() => AuthController());

    Get.lazyPut(() => SimCardController());
    Get.lazyPut(() => ProfileController());
  }
}

class SimBindung extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.put(() => SimCardController());
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileBindung extends Bindings {
  @override
  void dependencies() {
    // هنا تقوم بإضافة كل الـ Controllers الذين تحتاجهم
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => SimCardController());
    Get.put(() => ProfileController());
  }
}
