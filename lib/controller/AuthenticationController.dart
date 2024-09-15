// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/viwe/AdminPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var userName = ''.obs;
  var userProfilePic = ''.obs;
  var emailuser = ''.obs;
  SupabaseClient supabase = Supabase.instance.client;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late String countryCode;
  late String completeNumber;
  RxBool isLoading = false.obs;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signInWithEmail() async {
    isLoading.value = true; // عرض مؤشر التحميل
    if (emailController.text == "mohamed" &&
        passwordController.text == "mM20210377") {
      Get.to(AdminBookingPage());
    } else {
      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        sharedPreferences!.setString("id", "user");

        isLoading = false.obs;

        Get.offAllNamed("/home"); // الانتقال للصفحة الرئيسية
      } on FirebaseAuthException catch (e) {
       Get.snackbar('Error', 'Error during Email Sign-In: ${e.message}');
      } finally {
        isLoading.value = false; // إيقاف التحميل
      }
    }
  }

  //================= Google Sign In =================
  Future<void> signInWithGoogle() async {
    try {
      isLoading = true.obs;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      userName.value = googleUser.displayName ?? 'Unknown User';
      userProfilePic.value = googleUser.photoUrl ?? '';
      isLoading = true.obs;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await saveUserToSupabase(userCredential);
      sharedPreferences!.setString("id", "user");

      isLoading = false.obs;
      Get.offAllNamed("/home");
    } catch (e) {
Get.snackbar('error'.tr, 'Failedload'.tr);
    }
  }

  //================= Facebook Sign In =================
  Future<void> signInWithFacebook() async {
    isLoading = true.obs;
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        userName.value = userData['name'] ?? 'Unknown User';
        userProfilePic.value = userData['picture']['data']['url'] ?? '';

        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        await saveUserToSupabase(userCredential);
        sharedPreferences!.setString("id", "user");

        isLoading = false.obs;
        Get.offAllNamed("/home");
      } else {
       Get.snackbar('Error', 'Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'Failedload'.tr);
    }
  }

  Future<void> signInWithTwitter() async {
    isLoading = true.obs;
    try {
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();
      UserCredential? userCredential;

      if (kIsWeb) {
        userCredential =
            await FirebaseAuth.instance.signInWithPopup(twitterProvider);
      } else {
        userCredential =
            await FirebaseAuth.instance.signInWithProvider(twitterProvider);
      }

      if (userCredential.user != null) {
        userName.value = userCredential.user?.displayName ?? 'name User';
        userProfilePic.value = userCredential.user?.photoURL ?? '';
        emailuser.value = userCredential.user?.email ?? "user@goaraa.com";

        await saveUserToSupabase(userCredential);
        sharedPreferences!.setString("id", "user");

        isLoading = false.obs;
        Get.offAllNamed("/home");
      }
    } catch (e) {
        Get.snackbar('error'.tr, 'Failedload'.tr);
    }
  }

  //================= Helper Methods =================
  Future<void> saveUserToSupabase(UserCredential userCredential) async {
    isLoading = true.obs;
    try {
      String firebaseUid = userCredential.user?.uid ?? 'no-firebase-uid';

      // تحقق مما إذا كان المستخدم موجودًا في Supabase
      final response = await supabase
          .from('users')
          .select()
          .eq('firebaseUid', firebaseUid)
          .maybeSingle();

      if (response != null && response['firebaseUid'] != null) {
        // إذا كان المستخدم موجودًا، قم بتحديث البيانات إذا لزم الأمر
        await supabase.from('users').update({
          'nameUser': userName.value,
          'photoUrl': userProfilePic.value,
          'emailAuth': userCredential.user?.email,
          'mobileNumber': userCredential.user?.phoneNumber ?? '',
        }).eq('firebaseUid', firebaseUid);

        // استرجع UUID من البيانات المخزنة في Supabase
        String existingUserId = response['id'] ?? '';
        sharedPreferences!.setString("userId", existingUserId);
        // تخزين UUID في sharedPreferences
      } else {
        // إذا لم يكن firebaseUid موجودًا، قم بإدخال بيانات جديدة
        String generatedUuid = Uuid().v4(); // توليد UUID جديد
        sharedPreferences!.setString("firebaseUid", firebaseUid);
        sharedPreferences!.setString(
            "userId", generatedUuid); // تخزين UUID في sharedPreferences

        await supabase.from('users').insert({
          'id': generatedUuid, // استخدام UUID جديد كمعرف أساسي
          'firebaseUid': firebaseUid, // تخزين UID
          'nameUser': userName.value,
          'photoUrl': userProfilePic.value,
          'emailAuth': userCredential.user?.email,
          'mobileNumber': userCredential.user?.phoneNumber ?? '',
        });
        isLoading = false.obs;
      }
    } catch (e) {
    Get.snackbar('error'.tr, 'Failedload'.tr);
    }
  }
}
