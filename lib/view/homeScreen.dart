import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Charities near you"),
            ListView.builder(
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
                                  onPressed: () {}, icon: Icon(Icons.thumb_up)),
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 5,
                scrollDirection: Axis.vertical,
                shrinkWrap: true)
          ],
        ),
      ),
    );
  }
}
