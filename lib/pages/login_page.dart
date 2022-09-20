import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/register_page.dart';
import 'package:hackaton_momo/pages/send_sms_page.dart';
import 'package:hackaton_momo/pages/sms_verification_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var _obscureText = true;
  bool _isLoading = false;
  final List correctNum = [
    "670",
    "671",
    "672",
    "673",
    "674",
    "675",
    "676",
    "677",
    "678",
    "679",
    "650",
    "651",
    "652",
    "653",
    "654",
  ];

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: isKeyboard ? 18 : 30 + MediaQuery.of(context).padding.top,
            bottom: 18,
            left: 18,
            right: 18,
          ),
          child: Column(
            children: [
              isKeyboard
                  ? Container()
                  : Text(
                      'Entrez vos informations pour acceder à l’app',
                      style: GoogleFonts.ubuntu(
                        color: dGray,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Numéro de téléphone (MTN)",
                      style: GoogleFonts.ubuntu(
                        color: dGray,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: phoneController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) => value != null &&
                                value.length == 9 &&
                                correctNum.contains(value.substring(0, 3))
                            ? null
                            : 'Numéro de téléphone incorrect',
                        decoration: const InputDecoration(
                          prefix: Text(
                            '237',
                            style: TextStyle(color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Code d'accès",
                      style: GoogleFonts.ubuntu(
                        color: dGray,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        obscureText: _obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => value != null && value.length == 4
                            ? null
                            : 'Code d\'accès incorrect',
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: !_obscureText ? dBlue : dGray,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SendSmsPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Code d\'accès oublié ?',
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
              ),
              const Spacer(),
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
                          'Se Connecter',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pas encore inscrit ?",
                    style: GoogleFonts.ubuntu(
                      color: dGray,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "S'enregistrer",
                      style: GoogleFonts.ubuntu(
                        color: dBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    Map<String, dynamic> creds = {
      'phone': "237${phoneController.text.trim()}",
      'password': passwordController.text.trim(),
    };

    if (formKey.currentState!.validate()) {
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
              phone: "237${phoneController.text.trim()}",
              error: true,
            ),
          ),
        );
      } else {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        FlashMessage.showSnackBar(jsonResponse['message'], context);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
}
