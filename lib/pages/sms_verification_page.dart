import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';

import 'package:provider/provider.dart';

class SmsVerificationPage extends StatefulWidget {
  const SmsVerificationPage(
      {super.key,
      this.creds,
      this.iCode,
      required this.phone,
      required this.error});
  final bool error;
  final String phone;
  final String? iCode;
  final Map<String, dynamic>? creds;
  @override
  State<SmsVerificationPage> createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage> {
  bool _isLoading = false;
  final character1Controller = TextEditingController();
  final character2Controller = TextEditingController();
  final character3Controller = TextEditingController();
  final character4Controller = TextEditingController();
  String currentCode = "";
  String code = "1234";
  @override
  void initState() {
    super.initState();
    {
      currentCode = widget.iCode!;
      print(currentCode);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (widget.error) {
          FlashMessage.showSnackBar(
              "Your phone number is not actived", context);
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
            child: Column(
              children: [
                Text(
                  'Nous vous avons envoyé un code de verification par SMS',
                  style: GoogleFonts.ubuntu(
                    color: dGray,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.phone.substring(0, 5)}*****${widget.phone.substring(10)}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Changer le numéro de téléphone',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          color: dBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character1Controller,
                          onSaved: (pin1) {},
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          onSaved: (pin2) {},
                          controller: character2Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character3Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                              verify();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character4Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: sendSms,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(13),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: dBlue,
                                ),
                              )
                            : Text(
                                'Renvoyer',
                                style: GoogleFonts.ubuntu(
                                  color: dBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: verify,
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendSms() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Provider.of<Auth>(context, listen: false)
        .sendSms(phone: widget.phone, resetPassword: false);

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print("${jsonResponse['data']['code']}");
      currentCode = "${jsonResponse['data']['code']}";
      print(currentCode);
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      FlashMessage.showSnackBar(jsonResponse['message'], context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void verify() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.creds == null) {
      var response = await Provider.of<Auth>(context, listen: false)
          .verification(code: currentCode, phone: widget.phone);
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        FlashMessage.showSnackBar(jsonResponse['message'], context);
      }
    } else {
      if (currentCode == code) {
        var response = await Provider.of<Auth>(context, listen: false)
            .register(creds: widget.creds!);
        if (response.statusCode == 201) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          FlashMessage.showSnackBar(jsonResponse['message'], context);
        }
      } else {
        FlashMessage.showSnackBar("Incorrect code", context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
