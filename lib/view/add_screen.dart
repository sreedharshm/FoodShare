import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

int currentStep = 0;
bool isCompleted = false;
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
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: selectCharity,
                // ignore: prefer_const_constructors
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
        content: SingleChildScrollView(child: Container()),
      )
    ];

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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
  MyAddPageState createState() => MyAddPageState();
}

class MyAddPageState extends State<MyAddPage> {
  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.transparent,
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
  }
}
