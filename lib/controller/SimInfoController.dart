import 'package:fetch_mobile_numbers/sim_card/sim_card_info.dart';
import 'package:get/get.dart';
import 'package:fetch_mobile_numbers/fetch_mobile_numbers.dart';
import 'package:permission_handler/permission_handler.dart';

class SimCardController extends GetxController {
  var simCards = <SimCard>[].obs; // قائمة الشرائح
  var selectedSimIndex = (-1).obs; // تخزين الشريحة المختارة
  var selectedSimNumber = ''.obs; // تخزين رقم الشريحة المختارة

  final _fetchMobileNumbersPlugin = FetchMobileNumbers();

  @override
  void onInit() {
    super.onInit();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }
    fetchSimCards();
  }

  Future<void> fetchSimCards() async {
    List<SimCard>? mobileNumbers;
    try {
      mobileNumbers = await _fetchMobileNumbersPlugin.getMobileNumbers();
    } catch (e) {
      mobileNumbers = [];
    }
    simCards.value = mobileNumbers;
  }
}
