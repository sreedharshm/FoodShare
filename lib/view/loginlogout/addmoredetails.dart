import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodproject/view/Navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../color.dart';

class AddMoreDetails extends StatefulWidget {
  const AddMoreDetails({super.key});

  @override
  State<AddMoreDetails> createState() => _AddMoreDetailsState();
}

class _AddMoreDetailsState extends State<AddMoreDetails> {
  // Future<void> getdetails
//  getSpecie(String petId) async{
//     DocumentReference snapshot = FirebaseFirestore.instance.collection('Profile').doc(petId);
//     String imageurl;
//      await snapshot.get().then((snapshot) {
//       imageurl = snapshot.data['profileimage'].toString();
//     });
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Images Selected');
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false);
              },
              child: Text(
                "Skip",
                style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 130, 130, 130),
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Profile')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data found.');
            }
            if (snapshot.hasData) {
              var userData = snapshot.data!.data() as Map;
              String name = userData['name'];
              String email = userData['email'];
              String data = userData['profileimage'];
              String label = userData['label'];
              if (label == "normal")
                return ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Center(
                      child: Text(
                        "Tell us more about you",
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                    data,
                                  ),
                                ),
                          Positioned(
                            // bottom: -50,
                            // left: 80,
                            child: IconButton(
                              iconSize: 30,
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                            ),
                            bottom: -10,
                            left: 80,
                          ),
                        ],
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text("Add your Photo")),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          filled: true,
                          labelText: "Your Phone",
                          hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Share your Address for easy pickup",
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(
                      height: 10,
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
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CollectionReference usersCollection =
                            FirebaseFirestore.instance.collection('Profile');
                        DocumentReference userDocRef = usersCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid);
                        userDocRef.update({
                          'phone': _phoneController.text.trim(),
                          'address': _addressController.text,
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationScreen()),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(175, 50),
                          backgroundColor: tdBlue,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                  ],
                );
              else {
                return ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Center(
                      child: Text(
                        "You are registered as an organisation .Tell us more about you",
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                  ),
                                ),
                          Positioned(
                            // bottom: -50,
                            // left: 80,
                            child: IconButton(
                              iconSize: 30,
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                            ),
                            bottom: -10,
                            left: 80,
                          ),
                        ],
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text("Add your Photo")),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          filled: true,
                          labelText: "Your Phone",
                          hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Share your Address for easy Delivery",
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(
                      height: 10,
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
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Add a Bio",
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 130, 130, 130),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                    TextFormField(
                      controller: _aboutController,
                      minLines: 2,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          filled: true,
                          labelText: " Bio",
                          hintStyle: TextStyle(color: Color(0xffe6e5ed)),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.edit),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CollectionReference usersCollection =
                            FirebaseFirestore.instance.collection('Profile');
                        DocumentReference userDocRef = usersCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid);
                        userDocRef.update({
                          'phone': _phoneController.text.trim(),
                          'address': _addressController.text,
                        });
                        CollectionReference org = FirebaseFirestore.instance
                            .collection('Organisations');
                        org.doc(FirebaseAuth.instance.currentUser!.uid).set({
                          'name': name,
                          'about': _aboutController.text,
                          'acc_image':
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                          'address': _addressController.text,
                          'org_id': FirebaseAuth.instance.currentUser!.uid,
                          'image':
                              "https://img.freepik.com/premium-photo/child-adult-holding-money-jar-donation-saving-concept_49149-1117.jpg"
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationScreen()),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(175, 50),
                          backgroundColor: tdBlue,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                  ],
                );
              }
            } else
              return Container();
          }),
    );
  }
}
