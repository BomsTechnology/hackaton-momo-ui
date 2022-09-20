import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:provider/provider.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          title: Consumer<Auth>(
            builder: (context, auth, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auth.user.name,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    auth.user.phone,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )
                ],
              );
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 4, bottom: 5),
              child: const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.list_alt_rounded,
                  color: dBlue,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          backgroundColor: dBlue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Listing des transactions',
                style: GoogleFonts.ubuntu(
                  color: dGray,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ));
  }
}
