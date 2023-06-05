import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'color.dart';

class DonatePage extends StatefulWidget {
  final String id;
  const DonatePage({super.key, required this.id});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Organisations')
                .where('org_id', isEqualTo: widget.id)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final DocumentSnapshot snap = snapshot.data.docs[0];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(snap['acc_image']),
                            radius: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(children: [
                              Text(
                                snap['name'],
                                // overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    //color: tdWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                          )
                          //LinearProgressIndicator()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: Icon(Icons.favorite),
                          title: Column(children: [
                            LinearPercentIndicator(
                                barRadius: const Radius.circular(18)),
                            Text("22/2 Donations")
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: NetworkImage(snap['image']),
                      height: 250,
                      //width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "About this Charity",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          //color: tdWhite,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: Text(
                      snap['about'],
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child:
                    ElevatedButton(onPressed: () {}, child: Text("wish list"))),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Donate now")))
          ],
        ),
      ),
    );
  }
}
