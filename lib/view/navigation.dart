import 'package:flutter/material.dart';

import 'package:foodproject/view/add_screen.dart';
import 'package:foodproject/view/home_screen.dart';
import 'package:foodproject/view/notification_screen.dart';
import 'package:foodproject/view/profile_screen.dart';
import 'package:foodproject/view/search_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int value = 0;
  onTap(int index) {
    setState(() {
      value = index;
    });
  }

  final screen = const [
    HomeScreen(),
    Search(),
    Add(),
    Notificationscreen(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[value],
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
