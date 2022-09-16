import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                  action: const HomeScreen(),
                  imagePath: 'assets/transfert.png',
                  label: 'Transférer de l\'argent',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const HomeScreen(),
                  imagePath: 'assets/marchand.png',
                  label: 'Paiement marchand',
                )
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
                  action: const HomeScreen(),
                  imagePath: 'assets/depot.png',
                  label: 'Effectuer un dépôt d\'argent',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const HomeScreen(),
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
                  action: const HomeScreen(),
                  imagePath: 'assets/carte1.png',
                  label: 'Lier une carte de crédit',
                ),
                const SizedBox(
                  width: 20,
                ),
                buildCard(
                  action: const HomeScreen(),
                  imagePath: 'assets/carte2.png',
                  label: 'Créer une carte virtuelle',
                ),
              ],
            ),
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
      onTap: () {},
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
