import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/view/notification_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class MyAddPage extends StatefulWidget {
  final String selectCharitystring;
  final int currentStep;
  final String orgid;
  const MyAddPage(
      {Key? key,
      required this.selectCharitystring,
      required this.orgid,
      required this.currentStep})
      : super(key: key);
  @override
  MyAddPageState createState() => MyAddPageState();
}

class MyAddPageState extends State<MyAddPage> {
  late int currentStep = widget.currentStep;

  bool isCompleted = false;
  final itemName = TextEditingController();
  final itemQuantity = TextEditingController();
  final moreDescription = TextEditingController();
  TextEditingController selectCharity = TextEditingController();
  void assign() {
    selectCharity.text = widget.selectCharitystring;
    print(widget.orgid);
  }

// final itemName = TextEditingController();
  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Select charity'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: selectCharity,
                  decoration: InputDecoration(labelText: "Select Charity"),
                )
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Item details"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: itemName,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                ),
                TextFormField(
                  controller: itemQuantity,
                  decoration: const InputDecoration(labelText: "Quantity"),
                ),
                TextFormField(
                  controller: moreDescription,
                  decoration: const InputDecoration(labelText: "Description"),
                )
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Complete"),
          content: SingleChildScrollView(
              child: Container(
            child: ElevatedButton(
              child: Text("Confirm"),
              onPressed: () {
                FirebaseFirestore.instance.collection('Orders').add({
                  "sender": FirebaseAuth.instance.currentUser!.uid,
                  "receiver": widget.orgid,
                  "item": itemName.text,
                  "progress": 0,
                  "quantiy": itemQuantity.text,
                  "receivername": selectCharity.text,
                }).then((DocumentReference doc) {
                  FirebaseFirestore.instance
                      .collection('Profile')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "orders": FieldValue.arrayUnion([doc.id])
                  });
                  FirebaseFirestore.instance
                      .collection('Profile')
                      .doc('receiver')
                      .update({
                    "orders": FieldValue.arrayUnion([doc.id])
                  });
                });

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Notificationscreen()),
                );
              },
            ),
          )),
        )
      ];
  @override
  Widget build(BuildContext context) {
    assign();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Profile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data found.');
          }
          if (snapshot.hasData) {
            var userData = snapshot.data!.data() as Map;
            String label = userData['label'];
            if (label != 'org') {
              return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      shadowColor: Colors.transparent,
                      backgroundColor: tdBGcolor,
                      toolbarHeight: 60,
                      centerTitle: true,
                      titleTextStyle: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      title: const Text("Donate now"),
                    ),
                    body: Theme(
                      data: ThemeData(
                        colorScheme: const ColorScheme.light(primary: tdBlue),
                      ),
                      child: OverflowBox(
                        child: Stepper(
                          //physics: const ScrollPhysics(),
                          controlsBuilder: (context, controller) {
                            return const SizedBox.shrink();
                          },
                          type: StepperType.horizontal,
                          steps: getSteps(),
                          currentStep: currentStep,
                          onStepContinue: () {
                            if (currentStep < (getSteps().length - 1)) {
                              setState(() => currentStep += 1);
                              setState(() {
                                isCompleted = true;
                              });
                            }
                          },
                          onStepTapped: (step) => setState(() {
                            currentStep = step;
                          }),
                          onStepCancel: currentStep == 0
                              ? null
                              : () => setState(() => currentStep -= 1),
                          // controlsBuilder:(BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancell}) {
                          //   return Container(
                          //     child: Row(
                          //       children: [
                          //         Expanded(child: ElevatedButton(child: const Text("Next"), onPressed: onStepContinue,),
                          //         const SizedBox(width: 12),
                          //         Expanded(child: ElevatedButton(child: Text("Back"), onPressed: onStepCancel,),
                          //       ],
                          //     ),
                          //   ),
                          // },
                        ),
                      ),
                    )),
              );
            } else {
              return Scaffold(
                  body: Center(child: Text("Organisations cannot donate ")));
            }
          } else {
            return Container();
          }
        });
  }
}
