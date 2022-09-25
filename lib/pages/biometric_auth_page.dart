import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/account_page.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';
import 'package:provider/provider.dart';

class BiometricAuthPage extends StatefulWidget {
  const BiometricAuthPage({super.key, required this.value});
  final bool value;

  @override
  State<BiometricAuthPage> createState() => _BiometricAuthPageState();
}

class _BiometricAuthPageState extends State<BiometricAuthPage> {
  bool withBiometric = false;
  bool _isLoading = false;
  @override
  void initState() {
    withBiometric = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: const EdgeInsets.all(20),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: const Color(0xFFB7D2DB),
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.fingerprint_rounded,
                size: 100,
                color: dBlue,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Utilisez votre empreinte digitale pour vous authentifier',
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
                    setState(() => withBiometric = !withBiometric);
                  },
                  child: Text(
                    'Utiliser mon empreinte',
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
                    value: withBiometric,
                    activeColor: dBlue,
                    onChanged: (value) {
                      setState(() => withBiometric = value);
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: setWithBiometric,
                style: ElevatedButton.styleFrom(
                  backgroundColor: dBlue,
                  padding: const EdgeInsets.all(13),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
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

  void setWithBiometric() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Provider.of<Auth>(context, listen: false)
        .setWithBiometric(value: withBiometric);
    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const AccountPage(),
          ));
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      FlashMessage.showSnackBar(jsonResponse['message'], context);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
