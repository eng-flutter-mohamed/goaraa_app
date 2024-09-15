// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart'; // مكتبة لإنشاء معرفات فريدة

class ProfileController extends GetxController {
  final picker = ImagePicker();
  File? selectedImage;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = ''.obs;
  var isLoading = false.obs;
  TextEditingController nameController = TextEditingController();

  final supabase = Supabase.instance.client;
  final uuid = const Uuid(); // لإنشاء معرف فريد

  @override
  void onReady() {
    super.onReady();
    fetchUserData(); // جلب بيانات المستخدم عند جاهزية الـ Controller
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true); // عرض المؤشر أثناء التحميل

      // استعلام Supabase لجلب بيانات المستخدم من الجدول "users"
      final response = await supabase
          .from('users')
          .select('nameUser, emailAuth, photoUrl')
          .eq(
              'id',
              sharedPreferences!.getString("userId") ??
                  "") // هنا استخدم UUID أو معرف المستخدم المناسب
          .single();

      userName.value = response['nameUser'] ?? 'goaraa User';
      userEmail.value = response['emailAuth'] ?? 'user@goaraa.com';
      userImage.value = response['photoUrl'] ?? ''; // الصورة إن وجدت
      nameController.text = userName.value;
    } catch (e) {
      print('Failed to fetch user data: $e');
    } finally {
      isLoading(false); // إخفاء المؤشر بعد انتهاء التحميل
    }
  }

  void changeLocale() async {
    Locale currentLocale = Get.locale!;

    if (currentLocale.languageCode == 'ar') {
      Get.updateLocale(const Locale('en'));
      await sharedPreferences!.setString('locale', 'en');
    } else {
      Get.updateLocale(const Locale('ar'));
      await sharedPreferences!.setString('locale', 'ar');
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        await uploadImageToSupabase(); // رفع الصورة
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // رفع الصورة إلى Supabase
  Future<void> uploadImageToSupabase() async {
    try {
      isLoading.value = true;
      if (selectedImage != null) {
        final fileName = '${uuid.v4()}.jpg'; // إنشاء اسم فريد للصورة
        final filePath = 'amgesUser/$fileName';

        // رفع الصورة إلى Supabase storage
        await supabase.storage
            .from('amgesUser')
            .upload(filePath, selectedImage!);

        // الحصول على URL للصورة
        final downloadUrl =
            supabase.storage.from('amgesUser').getPublicUrl(filePath);

        userImage.value = downloadUrl; // حفظ الرابط للصورة المرفوعة

        // تحديث جدول users بإضافة رابط الصورة
        String userId = sharedPreferences!.getString("userId") ?? "";
        // تحديث الحقل الخاص بالصورة في جدول users
        final response = await supabase.from('users').update({
          'photoUrl': downloadUrl, // تحديث رابط الصورة في الحقل المناسب
        }).eq('id', userId); // التأكد من تحديث المستخدم الحالي فقط

        if (response.error != null) {
          print(
              'Error updating user profile image: ${response.error!.message}');
        } else {
          print('User profile image updated successfully.');
        }
      }
    } catch (e) {
      print("Error uploading image: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // void editUserName(String newName) async {
  //   try {
  //     String? userId = sharedPreferences!.getString("userId");
  //     if (userId != null) {
  //       await supabase
  //           .from('users')
  //           .update({'nameUser': newName}).eq('id', userId);
  //       userName.value = newName; // تحديث الحالة
  //     }
  //   } catch (e) {
  //     print('Error updating user name: $e');
  //   }
  // }

  Future<void> saveProfile() async {
    try {
      isLoading.value = true;

      String? downloadUrl = userImage.value.isNotEmpty ? userImage.value : '';
      String selectedPhoneNumber =
          sharedPreferences!.getString("mobileNumber") ?? "";

      if (nameController.text.isEmpty || selectedPhoneNumber.isEmpty) {
       Get.snackbar("Error", "Name and phone number cannot be empty");
        return;
      }

      // التحقق من وجود رقم الهاتف في قاعدة البيانات مسبقًا
      final existingUserByPhone = await supabase
          .from('users')
          .select()
          .eq('mobileNumber', selectedPhoneNumber)
          .maybeSingle();

      String? userId;

      if (existingUserByPhone != null) {
        // إذا كان المستخدم موجودًا بناءً على رقم الهاتف
        userId = existingUserByPhone['id'];
        sharedPreferences!.setString("userId", userId!); // تخزين الـ UUID
        print('User with phone number $selectedPhoneNumber already exists.');
      } else {
        // إذا لم يكن المستخدم موجودًا، إنشاء UUID جديد
        userId = sharedPreferences!.getString("userId");
        if (userId == null) {
          userId = uuid.v4(); // إنشاء UUID جديد
          sharedPreferences!.setString("userId", userId); // تخزينه محليًا
        }

        // إدخال بيانات المستخدم الجديدة
        await supabase.from('users').insert({
          'id': userId,
          'nameUser': nameController.text,
          'photoUrl': downloadUrl,
          'mobileNumber': selectedPhoneNumber,
        });
        print('New user created with UUID $userId');
      }

      // تحديث بيانات المستخدم في حال وجودها مسبقًا
      await supabase.from('users').update({
        'nameUser': nameController.text,
        'photoUrl': downloadUrl,
        'mobileNumber': selectedPhoneNumber,
      }).eq('id', userId);

     Get.snackbar("Success", "welcome_message".tr);
      Get.offAllNamed("/home"); // الانتقال إلى الصفحة الرئيسية بعد التحديث
    } catch (e) {
     Get.snackbar("error".tr, "Thisnumber".tr);
      print('Error saving profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
