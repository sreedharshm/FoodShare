import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.black87,
                  fontFamily: 'Schyler',
                  fontWeight: FontWeight.w500),
              "Charities near you"),
          ListView.builder(
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.orange,
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Image(
                            image: AssetImage("assets/images/google.png"),
                            color: Colors.amber,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite)),
                            title: LinearPercentIndicator(
                              barRadius: const Radius.circular(12),
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {},
                                child: const Text("Continue")),
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 5,
              scrollDirection: Axis.vertical,
              shrinkWrap: true),
          const Text("Ends here")
        ],
      ),
    );
  }
}