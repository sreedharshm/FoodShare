import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/view/color.dart';
import 'package:google_fonts/google_fonts.dart';

String name = "";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final CollectionReference orgDetails =
      FirebaseFirestore.instance.collection('Organisations');

  final TextEditingController _searchName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          shadowColor: Colors.transparent,
          backgroundColor: tdBGcolor,
          title: Card(
            child: TextField(
              controller: _searchName,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: "search here"),
              onChanged: (value) => setState(() {
                name = value;
              }),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: orgDetails.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var orgSnap = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (name.isEmpty) {
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                ),
                                IconButton(
                                    icon: const Icon(Icons.arrow_circle_right),
                                    iconSize: 40,
                                    color: tdBlue,
                                    splashColor: Colors.grey,
                                    onPressed: () {})
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if (orgSnap['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                ),
                                IconButton(
                                    icon: const Icon(Icons.arrow_circle_right),
                                    iconSize: 40,
                                    color: tdBlue,
                                    splashColor: Colors.grey,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('Profile')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .set({
                                        'name': 'fff',
                                        'email': 'dsfsdfs'
                                      });
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              } else {
                return Center(child: Text("no data here!"));
              }
            }));
  }
}
