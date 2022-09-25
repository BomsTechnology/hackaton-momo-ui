import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/enter_pin_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/pages/scanner_page.dart';

class AmountPage extends StatefulWidget {
  const AmountPage({super.key, required this.type});
  final String type;

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
                color: bgGray,
                borderRadius: BorderRadius.circular(45),
              ),
              child: widget.type == "Transfert d'argent"
                  ? Image.asset(
                      'assets/transfert.png',
                      width: 60,
                      height: 60,
                    )
                  : widget.type == "Paiement marchand"
                      ? Image.asset(
                          'assets/marchand.png',
                          width: 60,
                          height: 60,
                        )
                      : widget.type == "Paiement transport"
                          ? Image.asset(
                              'assets/transport.png',
                              width: 60,
                              height: 60,
                            )
                          : widget.type == "Dépôt d'argent"
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
              widget.type,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Entrez le montant',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 120,
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  suffix: Text("XFA", style: GoogleFonts.ubuntu()),
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      builder: (context) => ScannerPage(
                        type: widget.type,
                        amount: amountController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: dBlue,
                  padding: const EdgeInsets.all(13),
                ),
                child: Text(
                  'Transférer',
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
}
