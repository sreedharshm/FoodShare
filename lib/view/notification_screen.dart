import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/view/Order.dart';
import 'package:foodproject/view/color.dart';
import 'package:foodproject/view/yourorders.dart';
import 'package:google_fonts/google_fonts.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: tdBGcolor,
          toolbarHeight: 60,
          centerTitle: true,
          titleTextStyle: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 130, 130, 130),
              fontSize: 20,
              fontWeight: FontWeight.normal),
          title: const Text("Notification"),
        ),
        body: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .where('sender',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  // if (snapshot.hasError) {
                  //   return Text('Error: ${snapshot.error}');
                  // }
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Text('Loading...');
                  // }

                  // if (!snapshot.hasData || snapshot.data == null) {
                  //   return Text('No data found.');
                  //}
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: ((context, index) {
                        final DocumentSnapshot orgDetailsnap =
                            snapshot.data!.docs[index];
                        String name = orgDetailsnap['receivername'];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => YourOrderPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: tdBlue,
                                  style: BorderStyle.solid,
                                  width: 3,
                                )),
                                child: Center(
                                    child: Column(
                                  children: [
                                    const Center(
                                        heightFactor: 2,
                                        child: Text(
                                          "You have a pending orders to ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                    Text(name)
                                  ],
                                ))),
                          ),
                        );
                      }),
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Scaffold(
                      body: Center(
                          child: Container(child: Text("No notifications"))),
                    );
                  }
                })));
  }
}
