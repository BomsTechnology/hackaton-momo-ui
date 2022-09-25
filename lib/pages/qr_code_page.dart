import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/services/auth.dart';

import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Consumer<Auth>(
            builder: (context, auth, child) {
              return auth.user.type != 'Personnel'
                  ? Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 4, bottom: 5),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download_outlined,
                            color: dBlue,
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        backgroundColor: dBlue,
        centerTitle: true,
        title: Text(
          "QR CODE",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<Auth>(
        builder: (context, auth, child) {
          var message =
              "${auth.user.type} ${auth.user.name} ${auth.user.phone}";
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  auth.user.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: dBlue,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  auth.user.phone,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                QrImage(
                  data: message,
                  backgroundColor: Colors.white,
                  size: 250,
                  version: QrVersions.auto,
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
