import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/viwe/InvoicePage.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controller/ServiceIyimsController.dart';
import 'CustomColumn.dart';
import 'CustomLogo.dart';
import 'CustomLoading.dart';

class CustomColumnCategory extends StatelessWidget {
  final ServiceController controller;
  final String titlePage;

  const CustomColumnCategory({
    super.key,
    required this.controller,
    required this.titlePage,
  });

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 146, 73, 249),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double padding =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile
                  ? 16.0
                  : 100.0;

          return Column(
            children: [
              CustomLogo(
                heightCustom: heightScreen / 4,
                paddingVal: heightScreen / 8 / 8 / 8,
                child: Customcolumn(
                  flex: 5,
                  paddingVal: padding,
                  CustMain: MainAxisAlignment.center,
                  CustCross: CrossAxisAlignment.center,
                  chaled: Text(
                    titlePage,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subTitle: '',
                  logoImage: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: heightScreen / 8 / 13),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          "assets/ic_logo_border.png",
                          height: heightScreen / 2.9 / 2,
                          width: widthScreen / 2 / 1.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomLoading();
                    }

                    if (controller.services.isEmpty) {
                      return Center(child: Text('لا توجد بيانات'));
                    }

                    return ListView.builder(
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) {
                        final service = controller.services[index];
                        return Card(
                          child: Obx(
                            () => CheckboxListTile(
                              title: Text(service.name),
                              subtitle: Text(
                                  '${"price".tr} ${service.price} ${"pounds".tr}'),
                              value: service.isChecked.value,
                              onChanged: (bool? value) {
                                service.isChecked.value = value ?? false;
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: MaterialButton(
  onPressed: () {
    // جمع الخدمات المختارة
    final selectedServices = controller.services
        .where((service) => service.isChecked.value)
        .toList();

    if (selectedServices.isEmpty) {
      // إذا لم يتم اختيار أي خدمة، عرض حوار الخطأ
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'error'.tr,
        desc: 'must_select'.tr,
        btnOkOnPress: () {},
      ).show();
    } else {
      // حساب الإجمالي
      final total =
          selectedServices.fold(0.0, (sum, service) => sum + service.price);

      // الانتقال إلى صفحة الفاتورة مع الخدمات المختارة
      Get.to(() => InvoicePage(
            serviceName: selectedServices.map((s) => s.name).join(', '),
            total: total,
            price2: selectedServices.map((s) => s.price).toList(),
          ));
    }
  },
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0),
  ),
  height: 60,
  color: Colors.deepPurple[400],
  child: SizedBox(
    width: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "next".tr,
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 243, 235, 255),
        ),
      ],
    ),
  ),
),

    );
  }
}
