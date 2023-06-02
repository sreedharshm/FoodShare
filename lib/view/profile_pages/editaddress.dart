import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              initialValue: "dfdfd",
              decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              initialValue: "",
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Row(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: "689695",
                    decoration: InputDecoration(
                        labelText: "Pincode",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: "689695",
                    decoration: InputDecoration(
                        labelText: "Pincode",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
