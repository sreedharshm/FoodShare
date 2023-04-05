import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodproject/services/firebase_auth.dart';
import 'package:foodproject/view/Navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isloading = false;
  signuphere() async {
    _isloading = true;
    String s = await FireAuth.signUp(
        emailController: _emailController.text.trim(),
        passwordController: _passwordController.text.trim());
    if (s == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
          (route) => false);
    } else {
      setState(() {
        _isloading = false;
      });
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x0fe6e5ed), Color(0xfff4f0f4)],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,
            ),
            TextFormField(
              controller: _emailController,
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
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter password",
                  hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            ElevatedButton(
              onPressed: () {
                signuphere();
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 246, 109, 109)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)))),
              child: const Text("Sign up"),
            )
          ],
        ),
      ),
    );
  }
}
