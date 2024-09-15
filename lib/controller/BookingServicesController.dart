import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class BookingServicesController extends GetxController {
  final String userId = sharedPreferences!.getString("userId") ?? "";
  var bookingServices = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookingServicesData();
  }

  Future<void> fetchBookingServicesData() async {
    if (userId.isEmpty) {
     Get.snackbar('Error', 'عليك التسجيل');
      return;
    }

    try {
      isLoading(true);
      final response = await Supabase.instance.client
          .from('BookingServices')
          .select()
          .eq('userId', userId);
      bookingServices.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
  Get.snackbar('error'.tr, 'Failedload'.tr);
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await fetchBookingServicesData();
  }
}
