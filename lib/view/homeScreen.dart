import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodproject/view/add_screen.dart';
import 'package:foodproject/view/color.dart';
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
 

  final screen = [Search(), Add(), Profile(), Notificationscreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Charities near you",
              style: TextStyle(),
            ),
            ListView.builder(
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Color.fromARGB(255, 227, 227, 227),
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 8,
                            child: Image(
                              width: 100,
                              image: AssetImage("assets/images/google.png"),
                              color: Color.fromARGB(255, 197, 197, 197),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.favorite)),
                              title: LinearPercentIndicator(
                                barRadius: Radius.circular(24),
                              ),
                              trailing: ElevatedButton(
                                  onPressed: () {}, child: Text("Continue")),
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 5,
                scrollDirection: Axis.vertical,
                shrinkWrap: true),
            Text("Ends here")
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: " "),
        ],
      ),
    );
  }
}
