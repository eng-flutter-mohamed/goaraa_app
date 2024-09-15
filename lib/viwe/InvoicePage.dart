// ignore_for_file: file_names, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/customComponent/customButoom.dart';

import '../controller/ InvoiceController.dart';
import '../model/service.dart';
import '../viwe/BookingPag.dart'; // تأكد من استيراد النموذج المناسب

class InvoicePage extends StatelessWidget {
  final String serviceName;
  final num total;
  final List<double> price2;

  const InvoicePage({
    super.key,
    required this.serviceName,
    required this.total,
    required this.price2,
  });

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final controller = Get.put(InvoiceController(
      serviceName: serviceName,
      total: total,
      price2: price2,
    ));

    List<String> services = serviceName.split(', ');

    // دالة للحصول على سعر الخدمة بناءً على الاسم
    double getPriceForService(String serviceName) {
      int index = services.indexOf(serviceName);
      return price2[index];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'.tr),
      ),
      body: Column(
        children: [
          Container(
       
            height: heightScreen / 2,
            margin: EdgeInsets.symmetric(horizontal: widthScreen / 50,vertical: heightScreen/15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30), // نفس الـ borderRadius المستخدم في الزر
                side: const BorderSide(
                  color: Colors.deepPurpleAccent, // نفس اللون المستخدم في الزر
                  width: 1.2, // عرض الـ border ليكون مشابهًا للزر
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widthScreen / 30, vertical: heightScreen / 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      services[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${price2[index]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total'.tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$total',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widthScreen / 30,
              vertical: heightScreen/15
            ),
            child: CustomButton(
              onPressed: () {
                final selectedServices = services
                    .map((service) => Service(
                          name: service,
                          price: getPriceForService(service),
                        ))
                    .toList();

                print(selectedServices); // لطباعة الخدمات والتحقق منها

                Get.to(() => BookingPage(
                      selectedServices: selectedServices,
                    ));
              },
              ButtonColor: Colors.white,
              ButtonString: Text(
                'acceptable'.tr,
                style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
