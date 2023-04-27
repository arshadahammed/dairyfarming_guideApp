import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/root_app.dart';
import 'screens/spalsh_onboard/splash_screen.dart';
import 'theme/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: appBgColor.withOpacity(0.5)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Course App',
      theme: ThemeData(
        primaryColor: primary,    
      ),
      home: const SplashScreen(),
    );
  }
}
