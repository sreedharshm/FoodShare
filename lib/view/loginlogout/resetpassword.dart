import 'package:flutter/material.dart';
import 'package:foodproject/services/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isloading = false;
  final resetemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Forgot your Password?",
            style: TextStyle(fontSize: 20),
          ),
          const Text("Enter your email to get help logging in."),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: resetemail,
            decoration: const InputDecoration(
                filled: true,
                hintText: "Enter email or phone",
                hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(12)))),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isloading = true;
              });
              FireAuth.sendEmail(
                  email: resetemail.text.trim(), context: context);
              setState(() {
                _isloading = false;
              });
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 246, 109, 109)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))),
            child: _isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text("Send Email"),
          ),
        ],
      ),
    );
  }
}
