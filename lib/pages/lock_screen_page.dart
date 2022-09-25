import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/models/user.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/sms_verification_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LockScreenPage extends StatefulWidget {
  const LockScreenPage({super.key});

  @override
  State<LockScreenPage> createState() => _LockScreenPageState();
}

class _LockScreenPageState extends State<LockScreenPage> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  bool _isLoading = false;
  String code = "";
  String phone = "";
  User? user;
  @override
  void initState() {
    getInformation();
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> getInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(prefs.getString('user')!));
    setState(() {
      phone = user!.phone;
    });
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);

      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/security.png",
                    height: 250,
                  ),
                  Text(
                    'Entrez votre code d\'accès',
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    phone,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: dBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: code.isNotEmpty ? dBlue : Colors.white,
                          border: Border.all(width: 2, color: dBlue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: code.length >= 2 ? dBlue : Colors.white,
                          border: Border.all(width: 2, color: dBlue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: code.length >= 3 ? dBlue : Colors.white,
                          border: Border.all(width: 2, color: dBlue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: code.length == 4 ? dBlue : Colors.white,
                          border: Border.all(width: 2, color: dBlue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => enterDigit(0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Text(
                                    '0',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 30,
                                      color: dGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            InkWell(
                              onTap: () => enterDigit(1),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '1',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => enterDigit(2),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '2',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => enterDigit(3),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '3',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => enterDigit(4),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Text(
                                    '4',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 30,
                                      color: dGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            InkWell(
                              onTap: () => enterDigit(5),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '5',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => enterDigit(6),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '6',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => enterDigit(7),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '7',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => enterDigit(8),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Text(
                                    '8',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 30,
                                      color: dGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            InkWell(
                              onTap: () => enterDigit(9),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Text(
                                  '9',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    color: dGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _authenticateWithBiometrics,
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.fingerprint,
                                  color: dGray,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: deleteDigit,
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.backspace_rounded,
                                  color: dGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
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
                              'Valider',
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
      ),
    );
  }

  void enterDigit(int digit) async {
    if (code.length < 4) {
      setState(() {
        code = "$code$digit";
      });
    }
    print(code);
  }

  void deleteDigit() async {
    if (code.isNotEmpty) {
      setState(() {
        code = code.substring(0, code.length - 1);
      });
    }
    print(code);
  }

  void login() async {
    Map<String, dynamic> creds = {
      'phone': phone,
      'password': code,
    };

    if (code.length == 4) {
      setState(() {
        _isLoading = true;
      });
      var response =
          await Provider.of<Auth>(context, listen: false).login(creds: creds);
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (response.statusCode == 403) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SmsVerificationPage(
              phone: user!.phone,
              error: true,
            ),
          ),
        );
      } else {
        FlashMessage.showSnackBar("Code d'accès incorrect", context);
        setState(() {
          code = "";
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
