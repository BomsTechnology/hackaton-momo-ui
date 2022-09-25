import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';

class NoPinSettingPage extends StatefulWidget {
  const NoPinSettingPage({super.key});

  @override
  State<NoPinSettingPage> createState() => _NoPinSettingPageState();
}

class _NoPinSettingPageState extends State<NoPinSettingPage> {
  bool nopin = true;
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dBlue,
        title: Text(
          "Paiement Sans Pin",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isKeyboard
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(20),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        color: const Color(0xFFB7D2DB),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      Icons.pin,
                      size: 100,
                      color: dBlue,
                    ),
                  ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Effectuez vos paiements rapidement sans entrer de pin',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() => nopin = !nopin);
                  },
                  child: Text(
                    'Payer sans code',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      color: dGray,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Switch.adaptive(
                    value: nopin,
                    activeColor: dBlue,
                    onChanged: (value) {
                      setState(() => nopin = value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() => nopin = !nopin);
                  },
                  child: Text(
                    'Plafond de paiement',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      color: dGray,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "250",
                      suffix: Text("XFA", style: GoogleFonts.ubuntu()),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
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
                  'Enregistrer',
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
  }
}
