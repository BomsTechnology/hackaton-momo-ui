import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
import 'package:hackaton_momo/services/auth.dart';

import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.center, children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: dBlue,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    color: dGray,
                    Icons.person_search_rounded,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Mes Contacts",
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w700, color: dGray),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  color: Colors.white,
                  Icons.close,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                    },
                    icon: FutureBuilder<bool?>(
                      future: controller?.getFlashStatus(),
                      builder: ((context, snapshot) {
                        if (snapshot.data != null) {
                          return Icon(
                              color: Colors.white,
                              snapshot.data!
                                  ? Icons.flash_on
                                  : Icons.flash_off);
                        } else {
                          return Container();
                        }
                      }),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    icon: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return const Icon(
                            Icons.switch_camera,
                            color: Colors.white,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      color: Colors.white,
                      Icons.person_search_rounded,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
