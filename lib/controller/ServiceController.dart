// import 'package:get/get.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import '../model/service.dart';
// import '../viwe/InvoicePage.dart';

// class ServiceController extends GetxController {
//   RxList<Service> services = <Service>[].obs;
//   RxDouble total = 0.0.obs;
//   RxList<String> selectedServices = <String>[].obs;
//   RxList<double> selectedPrices = <double>[].obs;

//   ServiceController(List<Service> initialServices) {
//     services.addAll(initialServices);
//   }
//  void toggleService(int index) {
//   Service service = services[index];
//   service.isChecked.value = !service.isChecked.value;
//   if (service.isChecked.value) {
//     total.value += service.price;
//     selectedServices.add(service.name);
//     selectedPrices.add(service.price);
//   } else {
//     total.value -= service.price;
//     selectedServices.remove(service.name);
//     selectedPrices.remove(service.price);
//   }
//   services.refresh(); 
// }


//   void showErrorDialog(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.error,
//       animType: AnimType.rightSlide,
//       title: 'error'.tr,
//       desc: 'must_select'.tr,
//       btnOkOnPress: () {},
//     ).show();
//   }

//   void goToInvoicePage(BuildContext context) {
//     if (selectedServices.isEmpty) {
//       showErrorDialog(context);
//     } else {
//       Get.to(InvoicePage(
//         serviceName: selectedServices.join(', '),
//         total: total.value,
//         price2: selectedPrices,
//       ));
//     }
//   }
// }
