import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:goaraa_app_eg1/controller/NetworkController.dart';
import 'package:goaraa_app_eg1/viwe/BookingServicesPage.dart';
import 'package:goaraa_app_eg1/viwe/ProfilePage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'homePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ConnectivityController connectivityController = Get.put(ConnectivityController());// احصل على الـ controller

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookingServicesPage(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // متابعة حالة الاتصال وعرض إشعار إذا كان غير متصل
    ever(connectivityController.connectionStatus, (status) {
      if (status == ConnectivityResult.none) {
        Get.snackbar(
          'NoInternet'.tr,
          'notconnected'.tr,
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.transparent,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.houseMedical,
                size: 35, color: Color(0xff6c27c9)),
            title: Text("home".tr),
            selectedColor: const Color.fromARGB(255, 33, 233, 243),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.notesMedical,
                size: 35, color: Color(0xff6c27c9)),
            title: Text('Booking'.tr),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.person,
                size: 35, color: Color(0xff6c27c9)),
            title: Text('profile'.tr),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
