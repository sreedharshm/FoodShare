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

  final screen =  [
    HomeScreen(),
    Search(),
    Add(),
    Notificationscreen(),
    CharityProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[value],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(
          size: 25,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xFF284B63),
        onTap: onTap,
        currentIndex: value,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 139, 163, 178),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.search_outlined,
              ),
              icon: Icon(Icons.search_outlined),
              label: "Search"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_box_rounded),
              icon: Icon(Icons.add_box_outlined),
              label: "Add"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.notifications_active),
              icon: Icon(Icons.notifications_none_outlined),
              label: "Notifications"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_2_rounded),
              icon: Icon(Icons.person_2_outlined),
              label: "Profile"),
        ],
      ),
    );
  }
}
