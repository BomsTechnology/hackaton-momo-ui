import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_momo/pages/onboarding_page.dart';

const dBlue = Color(0xFF0F6987);
const bgGray = Color(0xFFB7D2DB);
const dGray = Color(0xff263238);
const dYellow = Color(0xffffcc00);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: dBlue,
      ),
      home: const OnboardingPage(),
    );
  }
}
