import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodproject/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

int currentStep = 0;
final itemName = TextEditingController();
final itemQuantity = TextEditingController();
final moreDescription = TextEditingController();
final selectCharity = TextEditingController();
// final itemName = TextEditingController();
List<Step> getSteps() => [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text('Select charity'),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: selectCharity,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(labelText: "Select Charity"),
            )
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Item details"),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: itemName,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextFormField(
              controller: itemQuantity,
              decoration: InputDecoration(labelText: "Quantity"),
            ),
            TextFormField(
              controller: moreDescription,
              decoration: InputDecoration(labelText: "Description"),
            )
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Complete"),
        content: Container(),
      )
    ];

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAddPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyAddPage extends StatefulWidget {
  final String title;

  const MyAddPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
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
          title: const Text("Donate now"),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastState = currentStep == getSteps().length - 1;
            if (isLastState) {
              print('completed');
              //firebase stuff that sreedarsh will do :)
            }
            setState(() => currentStep += 1);
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ));
  }
}
