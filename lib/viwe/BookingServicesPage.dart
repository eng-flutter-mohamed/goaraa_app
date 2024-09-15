import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/main.dart';
import '../controller/BookingServicesController.dart';

import '../customComponent/customLoading.dart';

class BookingServicesPage extends StatelessWidget {
  BookingServicesPage({super.key});
  final BookingServicesController controller =
      Get.put(BookingServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Booking'.tr,
            style: const TextStyle(
                color: Colors.deepPurpleAccent, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        } else if (controller.bookingServices.isEmpty) {
          return Center(child: Text('NoBooked'.tr));
        } else {
          return RefreshIndicator(
            onRefresh: controller.refreshData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: controller.bookingServices.length,
                itemBuilder: (context, index) {
                  final serviceData = controller.bookingServices[index];
                  final selectedServices =
                      serviceData['selectedServices'] as List<dynamic>?;

                  // حساب السعر الإجمالي
                  double totalPrice = 0;
                  if (selectedServices != null) {
                    totalPrice = selectedServices.fold(
                        0, (sum, service) => sum + (service['price'] ?? 0));
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 1.2,
                        ),
                      ),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildInfoCard(context, 'Bookingdate'.tr,
                                      serviceData['appointmentDate']),
                                  _buildInfoCard(context, 'Bookingtime'.tr,
                                      serviceData['appointmentTime']),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: _buildInfoCard(
                                  context,
                                  'Bookingstate'.tr,
                                  sharedPreferences!.getString("locale") == "en"
                                      ? (serviceData['status'] == "تحت المراجعة"
                                          ? "Under review"
                                          : serviceData['status'] ==
                                                  "في الطريق اليك"
                                              ? "On the way to you"
                                              : serviceData['status'] ==
                                                      "تمت الزياره بنجاح"
                                                  ? "The visit was successful"
                                                  : serviceData['status'])
                                      : (serviceData['status'] == "Under review"
                                          ? "تحت المراجعة"
                                          : serviceData['status'] ==
                                                  "On the way to you"
                                              ? "في الطريق اليك"
                                              : serviceData['status'] ==
                                                      "The visit was successful"
                                                  ? "تمت الزياره بنجاح"
                                                  : serviceData['status'])),
                            ),
                            const SizedBox(height: 20),
                            if (selectedServices != null &&
                                selectedServices.isNotEmpty)
                              _buildSelectedServices(context, selectedServices),
                            const SizedBox(height: 10),
                            Text(
                              '${"Totalprice".tr} ${totalPrice.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String? value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Colors.deepPurpleAccent,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          '$label ${value ?? 'غير متوفر'}',
          style: TextStyle(
              fontSize: sharedPreferences!.getString("locale") == "en"
                  ? 10.7.sp
                  : 12.8.sp),
        ),
      ),
    );
  }

  Widget _buildSelectedServices(BuildContext context, List<dynamic> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bookedservices'.tr,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services.map((service) {
            final serviceMap = service as Map<String, dynamic>;
            return _buildInfoCard(
                context, serviceMap['name'] ?? 'غير متوفر', '');
          }).toList(),
        ),
      ],
    );
  }
}
