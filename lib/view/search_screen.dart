import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/view/color.dart';
import 'package:google_fonts/google_fonts.dart';

String name = " ";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final CollectionReference orgDetails =
      FirebaseFirestore.instance.collection('Organisations');
  // final user = FirebaseAuth.instance.currentUser;
  // bool isLoading = false;

  // List<Map<String, dynamic>> _allUsers = [];

  // //list docIDs
  // List<String> docIDs = [];

  //get docIDs
  // Future<void> getDocId() async {
  //   print('start');
  //   await FirebaseFirestore.instance.collection('Organisations').get().then(
  //         (snapshot) => snapshot.docs.forEach(
  //           (document) {
  //             print(document.reference);
  //             docIDs.add(document.reference.id);
  //           },
  //         ),
  //       );
  // }
  // Example: Print debug statements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: tdBGcolor,
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text('Search'),
          titleTextStyle: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 130, 130, 130),
              fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
        body: StreamBuilder(
            stream: orgDetails.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot orgSnap = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 200, 200, 200)
                                          .withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 5)
                            ]),
                        height: 70,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    orgSnap['acc_image'].toString()),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        orgSnap['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      orgSnap['address'],
                                      style: TextStyle(fontSize: 15),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("no data here!"));
              }
            }));
  }
}
