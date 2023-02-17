import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thinktaktic/Home/mode.dart';
import 'package:thinktaktic/MainPage/main_page.dart';

import 'Splash Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Mode().ligttheme,
      darkTheme: Mode().darktheme,
      themeMode: Mode().getThemeMode(),
      routes: {
        '/splash': (context) => const SplashScreen(),
      },
      home: const MainPage(),
    );
  }
}
