import 'package:flutter/material.dart';
import 'package:foodproject/view/Donate.dart';
import 'package:foodproject/view/color.dart';
//import 'package:foodproject/view/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference orgDetails =
      FirebaseFirestore.instance.collection('Organisations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 130, 130, 130),
            fontSize: 20,
            fontWeight: FontWeight.normal),
        title: const Text("Charities near you"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //         fontSize: 20,
            //         color: Colors.black87,
            //         fontFamily: 'Schyler',
            //         fontWeight: FontWeight.w200),
            //     "Charities near you"),

            //ithu vene matiko

            const Text(
              "Kottayam",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            StreamBuilder(
                stream: orgDetails.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot orgDetailsnap =
                              snapshot.data.docs[index];
                          String imageUrl = orgDetailsnap['image'];
                          String orgName = orgDetailsnap['name'];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: tdBlue),
                              height: MediaQuery.of(context).size.height * 0.4,
                              //color: Colors.orange,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        fit: StackFit.expand,
                                        children: [
                                          Image(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              orgName,
                                              style: GoogleFonts.montserrat(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      child: Container(
                                    color: Colors.white10,
                                    child: ListTile(
                                      leading: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.favorite)),
                                      title: LinearPercentIndicator(
                                        barRadius: const Radius.circular(12),
                                      ),
                                      trailing: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const donatePage()),
                                            );
                                          },
                                          child: const Text("Donate")),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true);
                  } else {
                    return const Center(
                      child: Text("Unable to Connect"),
                    );
                  }
                }),
            const Text("Ends here")
          ],
        ),
      ),
    );
  }
}
