import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminBookingController extends GetxController {
  var isLoading = true.obs;
  var bookings = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchAllBookings();
    super.onInit();
  }

  // Fetch all booking data from Supabase
  Future<void> fetchAllBookings() async {
    try {
      final response = await Supabase.instance.client
          .from('BookingServices')
          .select();

      if (response.isEmpty) {
        bookings.clear();
      } else {
        bookings.value = List<Map<String, dynamic>>.from(response);
      }
    } catch (e) {
    Get.snackbar('error'.tr, 'Failedload'.tr);
    } finally {
      isLoading.value = false;
    }
  }
}
