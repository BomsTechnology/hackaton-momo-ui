import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';
import 'package:hackaton_momo/pages/home/screens/home_screen.dart';
import 'package:hackaton_momo/pages/home/screens/listing_screen.dart';
import 'package:hackaton_momo/pages/home/tabbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = <Widget>[
    const HomeScreen(),
    const ListingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void onChangerTab(int index) {
      setState(() {
        this.index = index;
      });
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(top: 10, left: 15),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Text(
              'SM',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dBlue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 4),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.qr_code_rounded,
                  color: dBlue,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 4),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: dBlue,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: TabBarWidget(
        index: index,
        onChangerTab: onChangerTab,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dBlue,
        child: const Icon(
          Icons.qr_code_rounded,
          color: dYellow,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
