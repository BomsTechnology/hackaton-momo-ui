import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/biometric_auth_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/no_pin_setting_page.dart';
import 'package:hackaton_momo/pages/onboarding_page.dart';
import 'package:hackaton_momo/services/auth.dart';
//
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dBlue,
        title: Text(
          "Mon Compte",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<Auth>(
                builder: (context, auth, child) {
                  var names = auth.user.name.split(" ");
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: bgGray,
                        child: Text(
                          '${names[0][0].toUpperCase()}${names.length > 1 ? names[1][0].toUpperCase() : ""}',
                          style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w700,
                            color: dBlue,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.user.name,
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w700,
                              color: dGray,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            auth.user.phone,
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w400,
                              color: dGray,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Sécurité",
                style: GoogleFonts.ubuntu(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.lock,
                    color: dBlue,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Changer le code d'accès",
                    style: GoogleFonts.ubuntu(
                      color: dGray,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.pin,
                    color: dBlue,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoPinSettingPage(
                            value: Provider.of<Auth>(context, listen: false)
                                .user
                                .noPin,
                            amount: Provider.of<Auth>(context, listen: false)
                                .user
                                .amountNoPin,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Paiement sans pin",
                          style: GoogleFonts.ubuntu(
                            color: dGray,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          Provider.of<Auth>(context, listen: false).user.noPin
                              ? "Activé"
                              : "Désactivé",
                          style: GoogleFonts.ubuntu(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BiometricAuthPage(
                          value: Provider.of<Auth>(context, listen: false)
                              .user
                              .withBiomrtric!),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.fingerprint_rounded,
                      color: dBlue,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          "Authentification Biométrique",
                          style: GoogleFonts.ubuntu(
                            color: dGray,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          Provider.of<Auth>(context, listen: false)
                                  .user
                                  .withBiomrtric!
                              ? "Activé"
                              : "Désactivé",
                          style: GoogleFonts.ubuntu(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Autres",
                style: GoogleFonts.ubuntu(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.supervised_user_circle_rounded,
                    color: dBlue,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "A Propos de nous",
                    style: GoogleFonts.ubuntu(
                      color: dGray,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  var response =
                      await Provider.of<Auth>(context, listen: false).logout();
                  if (response.statusCode == 201) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage(),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Déconnexion",
                      style: GoogleFonts.ubuntu(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
