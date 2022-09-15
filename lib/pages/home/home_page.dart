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
        backgroundColor: Colors.grey.shade200,
        title: const Text('HomePage'),
      ),
      body: screens[index],
      bottomNavigationBar: TabBarWidget(
        index: index,
        onChangerTab: onChangerTab,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dBlue,
        child: const Icon(Icons.sync_alt_rounded),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
