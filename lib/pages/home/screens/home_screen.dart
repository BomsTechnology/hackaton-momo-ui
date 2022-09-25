import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/onboarding_page.dart';
import 'package:hackaton_momo/pages/qr_code_page.dart';
import 'package:hackaton_momo/pages/scanner_page.dart';
import 'package:hackaton_momo/services/auth.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ));
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 5),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Consumer<Auth>(
              builder: (context, auth, child) {
                var names = auth.user.name.split(" ");
                return Text(
                  '${names[0][0].toUpperCase()}${names.length > 1 ? names[1][0].toUpperCase() : ""}',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w700,
                    color: dBlue,
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 4, bottom: 5),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrCodePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.qr_code_rounded,
                  color: dBlue,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 4, bottom: 5),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: dBlue,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        backgroundColor: dBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paiements',
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/transfert.png',
                  label: 'Transférer de l\'argent',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/marchand.png',
                  label: 'Paiement marchand',
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/transport.png',
                  label: 'Paiement transport',
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'CallBox',
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/depot.png',
                  label: 'Effectuer un dépôt d\'argent',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/retrait.png',
                  label: 'Effectuer un retrait d\'argent',
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Services Financiers',
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/carte1.png',
                  label: 'Lier une carte de crédit',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const ScannerPage(),
                  imagePath: 'assets/carte2.png',
                  label: 'Créer une carte virtuelle',
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                var response =
                    await Provider.of<Auth>(context, listen: false).logout();
                if (response.statusCode == 201) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                  );
                }
              },
              child: const Text('Deconnexion'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                customizedButtonChild: const Icon(
                  Icons.fingerprint,
                ),
                customizedButtonTap: () async {
                  await localAuth(context);
                },
                didOpened: () async {
                  await localAuth(context);
                },
              ),
              child: const Text(
                'use local_auth \n(Show local_auth when opened)',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await localAuth(context);
              },
              child: Text('Finger'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required String imagePath,
    required String label,
    required Widget action,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => action,
          ),
        );
      },
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgGray,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
