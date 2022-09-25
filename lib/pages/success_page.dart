import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/models/transaction.dart';
import 'package:hackaton_momo/pages/error_page.dart';
import 'package:hackaton_momo/pages/home/home_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key, required this.info, required this.transaction});
  final List info;
  final Transaction transaction;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  void initState() {
    print(widget.transaction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.close,
                color: dGray,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: widget.info[4] == "Transfert d'argent"
                    ? Image.asset(
                        'assets/transfert.png',
                        width: 60,
                        height: 60,
                      )
                    : widget.info[4] == "Paiement marchand"
                        ? Image.asset(
                            'assets/marchand.png',
                            width: 60,
                            height: 60,
                          )
                        : widget.info[4] == "Paiement transport"
                            ? Image.asset(
                                'assets/transport.png',
                                width: 60,
                                height: 60,
                              )
                            : widget.info[4] == "Dépôt d'argent"
                                ? Image.asset(
                                    'assets/depot.png',
                                    width: 60,
                                    height: 60,
                                  )
                                : Image.asset(
                                    'assets/retrait.png',
                                    width: 60,
                                    height: 60,
                                  ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                '${widget.info[4]}',
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  color: dGray,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                '${widget.info[1]}',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: dBlue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.info[2]}',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: dGray,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${widget.info[3]} XFA",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: dGray,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Réussi",
                    style: GoogleFonts.ubuntu(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "25 Sept 2022 10h30",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.grey,
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
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dBlue,
                    padding: const EdgeInsets.all(13),
                  ),
                  child: Text(
                    'Accueil',
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
