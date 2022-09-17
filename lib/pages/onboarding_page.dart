import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/login_page.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/onboarding1.png"),
                Text(
                  'Vos transactions Mobile Money faciles et rapides.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    color: dGray,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Nous mettons à votre disposition un ensemble de moyens pour effectuer vos transaction de facon plus optimale.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dBlue,
                      padding: const EdgeInsets.all(13),
                    ),
                    child: Text(
                      'Commencer',
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
