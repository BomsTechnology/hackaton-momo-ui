import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Pas de connexion internet.',
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  color: dGray,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    color: const Color(0xFFB7D2DB),
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.wifi_off_rounded,
                  size: 100,
                  color: dBlue,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Nous avons un probleme, veuillez vérifier votre connexion internet.',
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
