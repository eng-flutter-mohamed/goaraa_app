import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/AdminController.dart';
import '../customComponent/customLoading.dart';

class AdminBookingPage extends StatelessWidget {
  final AdminBookingController adminBookingController =
      Get.put(AdminBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Bookings'.tr,
            style: const TextStyle(
                color: Colors.deepPurpleAccent, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: Obx(() {
        if (adminBookingController.isLoading.value) {
          return const Center(child: CustomLoading());
        } else if (adminBookingController.bookings.isEmpty) {
          return Center(child: Text('No bookings found.'));
        } else {
          return RefreshIndicator(
            onRefresh: adminBookingController.fetchAllBookings,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: adminBookingController.bookings.length,
                itemBuilder: (context, index) {
                  final bookingData = adminBookingController.bookings[index];
                  final selectedServices =
                      bookingData['selectedServices'] as List<dynamic>?;

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
                            Text(
                              'User Name: ${bookingData['userName'] ?? 'N/A'}',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Phone Number: ${bookingData['phoneNumber'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Symptoms: ${bookingData['Symptoms'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
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
                                      'Date: ${bookingData['appointmentDate'] ?? 'N/A'}',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                                Card(
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
                                      'Time: ${bookingData['appointmentTime'] ?? 'N/A'}',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Location: Lat (${bookingData['location_lat'] ?? 'N/A'}), Lon (${bookingData['location_lon'] ?? 'N/A'})',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Status: ${bookingData['status'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            if (selectedServices != null &&
                                selectedServices.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Services:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: selectedServices.map((service) {
                                      final serviceMap =
                                          service as Map<String, dynamic>;
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: const BorderSide(
                                            color: Colors.deepPurpleAccent,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            '${serviceMap['name'] ?? 'Unknown'}',
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Total Price: ${totalPrice.toStringAsFixed(2)}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 10),
                            Text(
                              'Price: ${bookingData['price'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Created At: ${bookingData['createdAt'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.sp),
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
}
