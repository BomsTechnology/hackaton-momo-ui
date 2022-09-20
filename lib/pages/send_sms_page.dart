import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/reset_password_page.dart';
import 'package:hackaton_momo/utils/flash_message.dart';

class SendSmsPage extends StatefulWidget {
  const SendSmsPage({super.key});

  @override
  State<SendSmsPage> createState() => _SendSmsPageState();
}

class _SendSmsPageState extends State<SendSmsPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
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
                      'Pour réinitialiser votre code d\'accès, enter votre numéro de téléphone. ',
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => value != null &&
                                value.length == 9 &&
                                correctNum.contains(
                                    phoneController.text.substring(0, 3))
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
                  ],
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
                        builder: (context) => const ResetPasswordPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dBlue,
                    padding: const EdgeInsets.all(13),
                  ),
                  child: Text(
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
    );
  }
}
