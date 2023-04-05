import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodproject/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

int currentStep = 0;
List<Step> getSteps() => [
      Step(
        isActive: currentStep >= 0,
        title: Text('Food item'),
        content: Container(),
      ),
      Step(
        isActive: currentStep >= 1,
        title: Text("Address"),
        content: Container(),
      ),
      Step(
        isActive: currentStep >= 2,
        title: Text("Time"),
        content: Container(),
      ),
      Step(
        isActive: currentStep >= 3,
        title: Text("Complete"),
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
          toolbarHeight: 5,
          // centerTitle: true,
          // titleTextStyle: GoogleFonts.montserrat(
          //     color: const Color.fromARGB(255, 130, 130, 130),
          //     fontSize: 20,
          //     fontWeight: FontWeight.normal),
          // title: const Text("Donate now"),
        ),
        body: Stepper(
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            setState(() => currentStep += 1);
          },
          onStepCancel: () => setState(() => currentStep -= 1),
        ));
  }
}
