import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  BottomNav(this.page);
  int page;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  void getPage(int index) {
    setState(() {
      widget.page = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/perpus');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan nilai currentIndex dalam batas yang valid
    int currentIndex = (widget.page >= 0 && widget.page < 2) ? widget.page : 1;

    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: getPage,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Perpus"),
      ],
    );
  }
}
