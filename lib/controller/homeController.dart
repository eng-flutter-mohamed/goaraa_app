import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var data = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    // قم بتحميل البيانات من المصدر المناسب
    // على سبيل المثال: بيانات من API
    // هذا هو المكان الذي يمكنك فيه إضافة الشيفرة التي تحتاجها

    // مثال على تحديث البيانات
    data.value = ['Item 1', 'Item 2', 'Item 3']; // تحديث البيانات
  }

  void refreshData() {
    loadData(); // استدعاء لتحميل البيانات من جديد
  }
}
