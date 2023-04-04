import 'package:flutter/material.dart';
import 'package:foodproject/view/Homescren.dart';

import 'package:foodproject/view/add_screen.dart';

import 'package:foodproject/view/notification_screen.dart';
import 'package:foodproject/view/profile_screen.dart';
import 'package:foodproject/view/search_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int value = 0;
  onTap(int index) {
    setState(() {
      value = index;
    });
  }

  final screen = const [
    HomeScreenNav(),
    Search(),
    Add(),
    Profile(),
    Notificationscreen()
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
