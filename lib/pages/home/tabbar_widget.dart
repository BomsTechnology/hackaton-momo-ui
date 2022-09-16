import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_momo/main.dart';

class TabBarWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangerTab;
  const TabBarWidget(
      {super.key, required this.index, required this.onChangerTab});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(
        icon: Icon(Icons.no_cell),
        onPressed: null,
      ),
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            icon: const Icon(Icons.home),
            index: 0,
            label: 'Accueil',
          ),
          placeholder,
          buildTabItem(
            icon: const Icon(Icons.inbox_outlined),
            index: 1,
            label: 'Listings',
          )
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
    required String label,
  }) {
    final isSelected = index == widget.index;
    return SizedBox(
        height: 65,
        child: Column(
          children: [
            IconTheme(
              data: IconThemeData(color: isSelected ? dBlue : dGray),
              child: IconButton(
                onPressed: () => widget.onChangerTab(index),
                icon: icon,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.ubuntu(
                color: isSelected ? dBlue : dGray,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ));
  }
}
