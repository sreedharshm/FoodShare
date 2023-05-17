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
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  List<Map<String, dynamic>> _allUsers = [];

  //list docIDs
  List<String> docIDs = [];

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
  Future<void> getDocId() async {
    print('getDocId() called'); // Debug statement
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Organisations').get();
    print('Documents: ${querySnapshot.docs.length}'); // Debug statement

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      print(document.id);
      docIDs.add(document.id);
    }
  }


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
      body: Column(children: [
        Center(
          child: ElevatedButton(
              onPressed: () async {
                await getDocId();
              },
              child: const Text('ids')),
        )
      ]),
    );
  }
}
