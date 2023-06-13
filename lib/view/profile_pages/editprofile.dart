import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/services/firebase_auth.dart';
import 'package:foodproject/view/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: tdBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: tdBlack,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfilePage()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Profile')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snap = snapshot.data!.data() as Map;
              _phoneController.text = snap['phone'];
              _emailController.text = snap['email'];
              _addressController.text = snap['address'];
              _nameController.text = snap['name'];
              return Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.lato(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 100,
                                      blurRadius: 100,
                                      color: tdBlue.withOpacity(0.1),
                                      offset: Offset(0, 0))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (snap['profileimage'] == '')
                                      ? NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/foodproject-cfd0e.appspot.com/o/user%2Fprofileimages%2Fprofile-icon-9.png?alt=media&token=d2d64964-f3d5-4d40-bacf-4baed7b1275b",
                                        )
                                      : NetworkImage(snap['profileimage']),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: tdBlue),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Full Name",
                            hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                            // fillColor: Colors.white,
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Email",
                            hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                            //fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        //initialValue: "5656",
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Your Phone",
                            hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                            //fillColor: Colors.white,
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _addressController,
                        minLines: 2,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Your Address",
                            hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                            //fillColor: Colors.white,
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(175, 50),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              CollectionReference usersCollection =
                                  FirebaseFirestore.instance
                                      .collection('Profile');
                              DocumentReference userDocRef = usersCollection
                                  .doc(FirebaseAuth.instance.currentUser!.uid);
                              userDocRef.update({
                                'phone': _phoneController.text.trim(),
                                'address': _addressController.text,
                                'email': _emailController.text.trim(),
                                'name': _nameController.text,
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Profile Updated Succesffully")));

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(175, 50),
                                backgroundColor: tdBlue,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text(
                              "SAVE",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else
              return Container();
          }),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
