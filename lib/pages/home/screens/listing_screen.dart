import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/models/transaction.dart';
import 'package:hackaton_momo/services/auth.dart';
import 'package:provider/provider.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  List<Transaction> data = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var response =
        await Provider.of<Auth>(context, listen: false).listingTransaction();
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    var items = jsonResponse['data'] as List<dynamic>;
    items.forEach(
      ((element) {
        data.add(Transaction.fromJson(element));
      }),
    );
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 130),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                children: data.isNotEmpty
                    ? data.map((transaction) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: bgGray,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child:
                                        transaction.type == "Transfert d'argent"
                                            ? Image.asset(
                                                'assets/transfert.png',
                                                width: 30,
                                                height: 30,
                                              )
                                            : transaction.type ==
                                                    "Paiement marchand"
                                                ? Image.asset(
                                                    'assets/marchand.png',
                                                    width: 30,
                                                    height: 30,
                                                  )
                                                : transaction.type ==
                                                        "Paiement transport"
                                                    ? Image.asset(
                                                        'assets/transport.png',
                                                        width: 30,
                                                        height: 30,
                                                      )
                                                    : transaction.type ==
                                                            "Dépôt d'argent"
                                                        ? Image.asset(
                                                            'assets/depot.png',
                                                            width: 30,
                                                            height: 30,
                                                          )
                                                        : Image.asset(
                                                            'assets/retrait.png',
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.type,
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Provider.of<Auth>(context,
                                                        listen: false)
                                                    .user
                                                    .phone ==
                                                transaction.sender['phone']
                                            ? "${transaction.receiver['phone']} - ${transaction.amount}XFA"
                                            : "${transaction.sender['phone']} - ${transaction.amount}XFA",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }).toList()
                    : [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
