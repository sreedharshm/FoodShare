import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class OrderPage extends StatefulWidget {
  final String orderid;
  const OrderPage({super.key, required this.orderid});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isCompleted = false;
  final itemName = TextEditingController();
  final itemQuantity = TextEditingController();
  final moreDescription = TextEditingController();
  TextEditingController selectCharity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late String order1 = widget.orderid;
    return Scaffold(
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
          title: const Text("Orders"),
        ),
        body: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .doc(order1)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var orderData = snapshot.data!.data() as Map;
                int currentStep = orderData['progress'];
                return Theme(
                  data: ThemeData(
                    colorScheme: const ColorScheme.light(primary: tdBlue),
                  ),
                  child: OverflowBox(
                    alignment: Alignment.topCenter,
                    child: Stepper(
                      //physics: const ScrollPhysics(),
                      controlsBuilder: (context, controller) {
                        return const SizedBox.shrink();
                      },
                      type: StepperType.vertical,
                      steps: [
                        Step(
                          state: currentStep >= 0
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep >= 0,
                          title: const Text('Not Confirmed'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text(
                                    "Order needs to be confirmed by Organisation"),
                                if (orderData['receiver'] ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                  ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('Orders')
                                          .doc(order1)
                                          .update(
                                              {'progress': currentStep + 1});
                                    },
                                    child: Text("data"),
                                  )
                              ],
                            ),
                          ),
                        ),
                        Step(
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep >= 0,
                          title: const Text('Packed'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text("Gets updated if food is ready to ship"),
                                if (orderData['sender'] ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                  ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('Orders')
                                            .doc(order1)
                                            .update(
                                                {'progress': currentStep + 1});
                                      },
                                      child: Text("Packed"))
                              ],
                            ),
                          ),
                        ),
                        Step(
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep >= 0,
                          title: const Text('Delivered'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text("if item is delivered"),
                                ElevatedButton(
                                    onPressed: () {
                                      // FirebaseFirestore.instance
                                      //     .collection('Orders')
                                      //     .doc(order1)
                                      //     .update(
                                      //         {'progress': currentStep + 1});
                                    },
                                    child: Text("Delivered"))
                              ],
                            ),
                          ),
                        ),
                      ],
                      currentStep: currentStep,
                      onStepContinue: () {
                        if (currentStep < (2)) {
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
                );
              } else {
                return Container();
              }
            }));
  }
}
