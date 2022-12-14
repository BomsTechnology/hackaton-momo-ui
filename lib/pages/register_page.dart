import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/sms_verification_page.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:hackaton_momo/utils/flash_message.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  final List<String> accountTypeItems = [
    "Personnel",
    "Marchand",
    "Transporteur",
    "Callbox",
  ];
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
    "680",
    "650",
    "651",
    "652",
    "653",
    "654",
  ];
  String? accountType = "Personnel";
  var _obscureText = true;

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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: isKeyboard ? 10 : 10 + MediaQuery.of(context).padding.top,
              bottom: 18,
              left: 18,
              right: 18,
            ),
            child: Column(
              children: [
                isKeyboard
                    ? Container()
                    : Text(
                        'Entrez vos informations pour vous enregistrer',
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
                        "Nom complet",
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
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length > 1
                                  ? null
                                  : 'Entrez votre nom',
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Num??ro de t??l??phone (MTN)",
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
                                  value.replaceAll(" ", "").length == 9 &&
                                  correctNum.contains(value.substring(0, 3))
                              ? null
                              : 'Num??ro de t??l??phone incorrect',
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
                        "Type de compte",
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
                        child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                            items: accountTypeItems
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )))
                                .toList(),
                            value: accountType,
                            onChanged: (value) => {
                                  setState(() {
                                    accountType = value;
                                  })
                                }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Code d'acc??s",
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
                          validator: (value) =>
                              value != null && value.length == 4
                                  ? null
                                  : 'Code d\'acc??s incorrect',
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: register,
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
                            'S\'inscrire',
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
                      "D??j?? un compte ?",
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
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Se Connecter",
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
      ),
    );
  }

  void register() async {
    Map<String, dynamic> creds = {
      'phone': "237${phoneController.text.trim()}",
      'password': passwordController.text.trim(),
      'name': nameController.text.trim(),
      'type': accountType,
    };

    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var response = await Provider.of<Auth>(context, listen: false)
          .sendSms(phone: creds['phone'], resetPassword: false);

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SmsVerificationPage(
              creds: creds,
              phone: creds['phone'],
              iCode: "${jsonResponse['data']['code']}",
              error: false,
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
