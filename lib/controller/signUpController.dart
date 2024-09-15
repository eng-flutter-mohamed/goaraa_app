// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class SignUpController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool selectCheckbox2 = false;
  bool selectCheckbox1 = false;
  RxBool isEmailVerificationSent = false.obs;
  RxBool isLoading = false.obs; // حالة التحميل
  var userName = ''.obs;
  SupabaseClient supabase = Supabase.instance.client;

  // Firebase User instance
  final firebaseUser = FirebaseAuth.instance.currentUser;

  void newUser() async {
    if (formKey.currentState!.validate()) {
      // تأكد من إدخال الاسم
      if (name.text == "") {
       Get.snackbar('Error', 'Please enter your name');
        return;
      }

      isLoading.value = true; // بدء التحميل
      try {
        // Create new Firebase account
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
           
        );
         userName.value=name.text;
        // Get Firebase User UID
        String uid = credential.user!.uid;

        // Save user data to Supabase instead of Firestore
        await saveUserToSupabase(credential);

        // Send email verification
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          isEmailVerificationSent.value = true;
         Get.snackbar(
            "Verification Email Sent",
            "A verification email has been sent to ${user.email}. Please check your inbox.",
            snackPosition: SnackPosition.TOP,
            duration:const Duration(seconds: 5),
          );

          // Navigate to sign-in or OTP page
          Get.offAllNamed("/SignInPage");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
         Get.snackbar(
            'Error',
            "The password provided is too weak.",
            duration: Duration(seconds: 2),
          );
        } else if (e.code == 'email-already-in-use') {
         Get.snackbar(
            'Error',
            "The account already exists for that email.",
            duration: Duration(seconds: 2),
          );
        }
      } catch (e) {
        print(e);
      } finally {
        print(userName.value);
        isLoading.value = false; // انتهاء التحميل
      }
    }
  }

  // Save user data to Supabase
  Future<void> saveUserToSupabase(UserCredential userCredential) async {
    try {
      String firebaseUid = userCredential.user?.uid ?? 'no-firebase-uid';

      // Check if user already exists in Supabase
      final response = await supabase
          .from('users')
          .select()
          .eq('firebaseUid', firebaseUid)
          .maybeSingle();

      if (response != null && response['firebaseUid'] != null) {
        // If the user exists, update existing data
        await supabase.from('users').update({
          'nameUser': userName.value, // تأكد من أن هذا الحقل يحتوي على الاسم
          'photoUrl': '',
          'emailAuth': userCredential.user?.email,
          'mobileNumber': userCredential.user?.phoneNumber ?? '',
        }).eq('firebaseUid', firebaseUid);

        // Retrieve UUID stored in Supabase
        String existingUserId = response['id'] ?? '';
        sharedPreferences!.setString("userId", existingUserId); // Save UUID
      } else {
        // If not, insert new data
        String generatedUuid = Uuid().v4(); // Generate new UUID
        sharedPreferences!.setString("firebaseUid", firebaseUid);
        sharedPreferences!.setString("userId", generatedUuid); // Save UUID

        await supabase.from('users').insert({
          'id': generatedUuid, // New UUID as the primary key
          'firebaseUid': firebaseUid, // Save Firebase UID
          'nameUser': userName.value, // تأكد من إدخال الاسم هنا
          'photoUrl': '', // Add a profile picture if needed
          'emailAuth': userCredential.user?.email,
          'mobileNumber': userCredential.user?.phoneNumber ?? '',
        });
      }
    } catch (e) {
   Get.snackbar('error'.tr, 'Failedload'.tr);
    }
  }
}
