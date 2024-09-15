import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/controller/homeController.dart';

class ConnectivityController extends GetxController {
  var connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    try {
      final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      if (result.isNotEmpty) {
        _updateConnectionStatus(result);
      }
    } catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    final ConnectivityResult currentStatus = result.isNotEmpty ? result.last : ConnectivityResult.none;

    if (currentStatus != ConnectivityResult.none && connectionStatus.value == ConnectivityResult.none) {
  try {
  Get.snackbar(
    'ConnectionRestored'.tr,
    'Internetconnection'.tr,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 3),
  );
} catch (e) {
  print('Error showing Snackbar: $e');
}

     Get.find<HomeScreenController>().refreshData();


    }

    connectionStatus.value = currentStatus;
    developer.log('Connectivity changed: $currentStatus');
  }
}
