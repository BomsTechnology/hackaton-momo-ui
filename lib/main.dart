import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/lock_screen_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/onboarding_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:local_auth/local_auth.dart';

const dBlue = Color(0xFF0F6987);
const bgGray = Color(0xFFB7D2DB);
const dGray = Color(0xff263238);
const dYellow = Color(0xffffcc00);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        // Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMMoney',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: dBlue,
      ),
      home: const Started(),
    );
  }
}

class Started extends StatefulWidget {
  const Started({super.key});

  @override
  State<Started> createState() => _StartedState();
}

class _StartedState extends State<Started> {
  bool isAuth = false;
  late StreamSubscription subscription;
  bool hasInternet = false;

  getConnectivity() {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  void initState() {
    getConnectivity();
    _checkIfLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasInternet) {
      return isAuth ? const LockScreenPage() : const OnboardingPage();
    } else {
      return const NoInternetPage();
    }
  }
}
