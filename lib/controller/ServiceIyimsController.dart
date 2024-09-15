import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/service.dart';

class ServiceController extends GetxController {
  final supabase = Supabase.instance.client;
  var services = <Service>[].obs;
  var isLoading = false.obs;

  // جلب الخدمات حسب الفئة من Supabase
  Future<void> fetchServices(String category) async {
    try {
      isLoading(true);

      final response = await supabase
          .from('medical_services')
          .select()
          .eq('category', category)
          ;



      final data = response as List<dynamic>;

      if (data.isNotEmpty) {
        services.value = data.map<Service>((item) {
          return Service(
            name: item['service_key'].toString().tr,
            price: item['price'].toDouble(),
          );
        }).toList();
      } else {
        services.clear(); // في حال عدم وجود بيانات
      }
    } catch (e) {
    print(e);
    } finally {
      isLoading(false);
    }
  }
}
