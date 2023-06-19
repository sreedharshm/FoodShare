import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/services/firebase_auth.dart';
import 'package:foodproject/view/Navigation.dart';
import 'package:foodproject/view/loginlogout/addmoredetails.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? val = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  // ignore: unused_field
  bool _isloading = false;
  signuphere() async {
    _isloading = true;
    String s = await FireAuth().signUp(
        emailController: _emailController.text.trim(),
        passwordController: _passwordController.text.trim());
    if (s == "success") {
      await FirebaseFirestore.instance
          .collection('Profile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': '',
        'address': '',
        'profileimage': '',
        'label': val! ? "org" : "normal",
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AddMoreDetails()),
          (route) => false);
    } else {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x0fe6e5ed), Color(0xfff4f0f4)],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 250,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    filled: true,
                    hintText: "Name",
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
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Checkbox(
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                  ),
                  Text("You are an Organisation")
                ],
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
      ),
    );
  }
}
