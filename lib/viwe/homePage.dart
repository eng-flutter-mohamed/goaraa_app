import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/viwe/PhysicalTherapyPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/ProfileController.dart';
import '../customComponent/containarHomeCust.dart';
import '../customComponent/customRowHome.dart';
import 'LabPage.dart';
import 'NursingPage.dart';
import 'ProfilePage.dart';
import 'doctorPage.dart';
// استيراد SocialAuthentication

class HomePageController extends GetxController {
  var activeIndex = 0.obs;

  void updateIndex(int index) {
    activeIndex.value = index;
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController controller = Get.put(HomePageController());
  final ProfileController controllerData = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("hello".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      width: screenWidth / 2.5,
                      child: Obx(() => Text(
                            controllerData.userName.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Get.to(() => ProfilePage()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xffd1c4e9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: CarouselSlider(
              items: [
                InkWell(
                    onTap: () {
                      Get.to(() =>const PhysicalTherapypage());
                    },
                    child: Customrowhome(
                        ImageHome: "assets/photo.png",
                        textImage: "Slider2".tr)),
                InkWell(
                    onTap: () {
                      Get.to(() =>   const NursingPage()); //PhysicalTherapyPage
                    },
                    child: Customrowhome(
                        ImageHome: "assets/photo1.png",
                        textImage: "Slider1".tr)),
                InkWell(
                    onTap: () {
                      Get.to(() =>  const Labpage());
                    },
                    child: Customrowhome(
                        ImageHome: "assets/photo2.png",
                        textImage: "Slider4".tr)),
                InkWell(
                    onTap: () {
                      Get.to(() =>  const DoctorPage());
                    },
                    child: Customrowhome(
                        ImageHome: "assets/photo3.png",
                        textImage: "Slider3".tr)),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  controller.updateIndex(index);
                },
              ),
            ),
          ),
          Center(
            child: Obx(() => AnimatedSmoothIndicator(
                  effect: const WormEffect(
                    dotWidth: 16,
                    dotHeight: 16,
                    activeDotColor: Color(0xff6c27c9),
                    dotColor: Colors.grey,
                    spacing: 8.0,
                  ),
                  activeIndex: controller.activeIndex.value,
                  count: 4,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Text(
              "choose_serviss".tr,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14.0,
              mainAxisSpacing: 14.0,
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() =>  const NursingPage());
                  },
                  child: Containarhomecust(
                    laboleHome: "nursing".tr,
                    ImageHome: const AssetImage("assets/NursePhoto.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() =>  const PhysicalTherapypage());
                  },
                  child: Containarhomecust(
                    laboleHome: "physicalـtherapy".tr,
                    ImageHome: const AssetImage("assets/11.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() =>  const DoctorPage());
                  },
                  child:  Containarhomecust(
                    laboleHome: "doctor".tr,
                    ImageHome:const AssetImage("assets/DoctorPhoto.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Labpage());
                  },
                  child: Containarhomecust(
                    laboleHome: "lab".tr,
                    ImageHome: const AssetImage("assets/12.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
