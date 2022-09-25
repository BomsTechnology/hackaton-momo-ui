import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/error_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/scanner_page.dart';
import 'package:hackaton_momo/pages/success_page.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({super.key});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  bool _isLoading = false;
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                      color: const Color(0xFFB7D2DB),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.lock,
                    size: 100,
                    color: dBlue,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Entrez votre code pin pour valider la transaction',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "2000 XFA",
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: dBlue,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Bondico02 - 237658401181",
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: dGray,
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
                        color: code.length >= 4 ? dBlue : Colors.white,
                        border: Border.all(width: 2, color: dBlue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    // Container(
                    //   height: 15,
                    //   width: 15,
                    //   decoration: BoxDecoration(
                    //     color: code.length == 5 ? dBlue : Colors.white,
                    //     border: Border.all(width: 2, color: dBlue),
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    // ),
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
                                width: 60,
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
                              width: 60,
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
                              width: 60,
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
                              width: 60,
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
                                width: 60,
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
                              width: 60,
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
                              width: 60,
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
                              width: 60,
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
                                width: 60,
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
                              width: 60,
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
                            onTap: deleteDigit,
                            child: const SizedBox(
                              width: 60,
                              height: 30,
                              child: Icon(
                                Icons.backspace_rounded,
                                color: dGray,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ErrorPage(),
                        ),
                      );
                    },
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
}
