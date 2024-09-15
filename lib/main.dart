import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goaraa_app_eg1/Middleware/AuthMiddleware.dart';
import 'package:goaraa_app_eg1/bindings/bindingApp.dart';
import 'package:goaraa_app_eg1/controller/homeController.dart';
import 'package:goaraa_app_eg1/viwe/startpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Translation/Translation.dart';
import 'firebase_options.dart';
import 'viwe/HOmeScreen.dart';
import 'viwe/SimCardSelactPage.dart';
import 'viwe/SplashScreenPage.dart';
import 'viwe/findPage.dart';
import 'viwe/homePage.dart';
import 'viwe/signUp.dart';
import 'viwe/signin.dart';


SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cuzcsrkylfnaathhnfgg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1emNzcmt5bGZuYWF0aGhuZmdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU4MzYwMjcsImV4cCI6MjA0MTQxMjAyN30.aMA2g6otYp0FXpt7JVTyw3LiEXluZj59ZmMChtvNtYY',
  );
  sharedPreferences = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  String? localeCode = sharedPreferences!.getString('locale');
  Locale initialLocale = localeCode != null
      ? Locale(localeCode)
      : Get.deviceLocale ?? Locale('ar');

  // تسجيل الcontroller
  
 Get.put(HomeScreenController());
  runApp(
    MyApp(
      initialLocale: initialLocale,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialLocale});
  final Locale initialLocale;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // إعداد حجم التصميم الأساسي (iPhone X كمثال)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          getPages: [
            GetPage(
              name: "/",
              page: () => const SplashScreenPage(),
              middlewares: [AuthMiddleware()],
            ),
            GetPage(name: "/SignUpPage", page: () => const SignupPage()),
            GetPage(name: "/SignInPage", page: () => const SignInPage()),
            GetPage(
                name: "/LoginPage",
                page: () => const SimCardSelectPage(),
                binding: SimBindung()),
            GetPage(name: "/Find", page: () => const FindPage()),
            GetPage(
                name: "/home",
                page: () => const HomeScreen(),
                binding: ProfileBindung()),
            GetPage(name: "/home2", page: () => HomePage()),
            GetPage(
                name: "/welcome",
                page: () => const WelcomPage(),
                binding: AuthBinding()),
          ],
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          translations: Translation(),
          locale: initialLocale,
          fallbackLocale: Get.deviceLocale,
          useInheritedMediaQuery: true,
        );
      },
    );
  }
}
