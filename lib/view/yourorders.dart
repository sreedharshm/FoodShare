import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Order.dart';
import 'color.dart';

class YourOrderPage extends StatefulWidget {
  const YourOrderPage({super.key});

  @override
  State<YourOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<YourOrderPage> {
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
        title: const Text("Your Orders"),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Profile')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
                children: data['orders'].map<Widget>((e) {
              return StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(e.toString())
                      .snapshots(),
                  builder: (context, AsyncSnapshot sn) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (sn.hasData) {
                      Map<String, dynamic> OrderData =
                          sn.data!.data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(orderid: e.toString())));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: tdBlue,
                                style: BorderStyle.none,
                                width: 3,
                              )),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(
                                    "You have a pending orders to ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "Click Here",
                                    style:
                                        TextStyle(fontSize: 20, color: tdBlue),
                                  ),
                                ],
                              ))),
                        ),
                      );
                    } else
                      return Container();
                  });
            }).toList());
          },
        ),
      ),
    );
  }
}
