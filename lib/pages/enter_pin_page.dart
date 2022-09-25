import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/error_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/scanner_page.dart';
import 'package:hackaton_momo/pages/success_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';
import 'package:provider/provider.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({
    super.key,
    required this.data,
    // required this.type,
    // required this.amount
  });
  final List data;
  // final String type;
  // final String amount;

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  bool _isLoading = false;
  String code = "";
  @override
  void initState() {
    print(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  "${widget.data[3]} XFA",
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
                  "${widget.data[1]} - ${widget.data[2]}",
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
                                width: 50,
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
                              width: 50,
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
                              width: 50,
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
                              width: 50,
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
                                width: 50,
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
                              width: 50,
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
                              width: 50,
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
                              width: 50,
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
                                width: 50,
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
                              width: 50,
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
                              width: 50,
                              height: 30,
                              child: Icon(
                                Icons.backspace_rounded,
                                color: dGray,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
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
                    onPressed: validate,
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

  void validate() async {
    Map<String, dynamic> creds = {
      'phone': Provider.of<Auth>(context, listen: false).user.phone,
      'password': code,
    };

    if (code.length == 4) {
      setState(() {
        _isLoading = true;
      });
      var response = await Provider.of<Auth>(context, listen: false)
          .verifyPass(creds: creds, save: false);

      if (response.statusCode == 201) {
        Map<String, dynamic> data = {
          'amount': widget.data[3],
          'currency': 'EUR',
          'payerMessage':
              "${widget.data[3]} from ${Provider.of<Auth>(context, listen: false).user.phone} to ${widget.data[2]}",
          'type': widget.data[4],
          'sender': Provider.of<Auth>(context, listen: false).user.phone,
          'receiver': widget.data[2],
        };
        var response =
            await Provider.of<Auth>(context, listen: false).collect(data: data);
        if (response.statusCode == 201) {
          var response = await Provider.of<Auth>(context, listen: false)
              .deposit(data: data);
          if (response.statusCode == 201) {
            var jsonResponse =
                jsonDecode(response.body) as Map<String, dynamic>;
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessPage(
                  info: widget.data,
                  // transaction: jsonResponse['data']['user']
                ),
              ),
            );
          } else {
            var jsonResponse =
                jsonDecode(response.body) as Map<String, dynamic>;
            FlashMessage.showSnackBar(jsonResponse['message'], context);
            setState(() {
              code = "";
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ErrorPage(
                  message: jsonResponse['message'],
                ),
              ),
            );
          }
        } else {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          FlashMessage.showSnackBar(jsonResponse['message'], context);
          setState(() {
            code = "";
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ErrorPage(
                message: jsonResponse['message'],
              ),
            ),
          );
        }
      } else {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        FlashMessage.showSnackBar("Pin Incorrect", context);
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
