import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: dGray,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Image.asset(
                'assets/transfert.png',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Transfert d\'argent',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Bondico02",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: dBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "237658401181",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: dGray,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "2000 XFA",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: dGray,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Echoué",
                  style: GoogleFonts.ubuntu(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "25 Sept 2022 10h30",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.grey,
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
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: dBlue,
                  padding: const EdgeInsets.all(13),
                ),
                child: Text(
                  'Accueil',
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
    );
    ;
  }
}
