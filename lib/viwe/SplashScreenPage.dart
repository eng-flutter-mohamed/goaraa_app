import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/SplashControlle.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final SplashController controller = Get.put(SplashController());
  final PageController _pageController = PageController(); // إضافة PageController للتحكم بالتنقل

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(() {
        final pages = controller.pages;

        return Stack(
          children: [
            // PageView مع PageController للتنقل بين الصفحات
            PageView.builder(
              controller: _pageController, // استخدام الـ PageController
              itemCount: pages.length,
              onPageChanged: (index) {
                controller.updateIndex(index);
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return _Image(
                  page: page,
                  size: screenHeight,
                );
              },
            ),
            // زر التنقل
            Positioned(
              bottom:screenHeight/5.5 ,
              right: screenWidth/2.3,
              child: GestureDetector(
                onTap: () {
                  if (controller.currentIndex.value == pages.length - 1) {
                    controller.onFinish(); // الانتقال إلى الشاشة الترحيبية
                  } else {
                    _pageController.nextPage( // التنقل إلى الصفحة التالية
                      duration: const Duration(milliseconds: 500), // مدة الحركة
                      curve: Curves.easeInOut, // منحنى الحركة
                    );
                  }
                },
                child: Container(
                  height: screenHeight / 11,
                  width: screenHeight / 11,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  ),
                  child: Icon(
                    Icons.navigate_next,
                    size: screenWidth * 0.08,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.page,
    required this.size,
  });

  final PageData page;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(page.image ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PageData {
  final String? image;
  final Color bgColor;

  const PageData({
    this.image,
    this.bgColor = Colors.white,
  });
}
