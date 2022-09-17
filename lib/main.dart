import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/onboarding_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:provider/provider.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: dBlue,
      ),
      home: Started(),
    );
  }
}

class Started extends StatefulWidget {
  const Started({super.key});

  @override
  State<Started> createState() => _StartedState();
}

class _StartedState extends State<Started> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      return auth.authenticated ? const HomePage() : const OnboardingPage();
    });
  }
}
