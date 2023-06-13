import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodproject/services/firebase_auth.dart';
import 'package:foodproject/view/color.dart';
import 'package:foodproject/view/profile_pages/about.dart';
import 'package:foodproject/view/profile_pages/editprofile.dart';
import 'package:foodproject/view/profile_pages/help.dart';
import 'package:foodproject/view/profile_pages/history.dart';
import 'package:foodproject/view/profile_pages/settings.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'login.dart';

//
class Profile1 extends StatefulWidget {
  const Profile1({super.key});

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  // fetchCurrentUserDetails() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference usersCollection = firestore.collection('Profile');

  //   usersCollection
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       // Document exists, retrieve user details

  //       data = documentSnapshot.get('profileimage')!;
  //       name = documentSnapshot.get('name')!;
  //       email = documentSnapshot.get('email')!;

  //       // String email = data['email'];
  //       // String username = data['username'];

  //       // // Use the user details as needed
  //       // print('Email: $email');
  //       print(name + data + email);
  //       print('Success');
  //     } else {
  //       // Document does not exist
  //       print("no data");
  //     }
  //   }).catchError((error) {
  //     // Error retrieving user details
  //     print("error");
  //   });
  //   await Future.delayed(Duration(seconds: 1));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Profile')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                    return Column(children: [
                      data == ''
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/foodproject-cfd0e.appspot.com/o/user%2Fprofileimages%2Fprofile-icon-9.png?alt=media&token=d2d64964-f3d5-4d40-bacf-4baed7b1275b'),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data),
                            ),
                      Text(name,
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(email,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ]);
                  } else
                    return Container();
                }),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: Column(
                    children: [
                      Text('Edit Profile',
                          style: TextStyle(
                              color: tdWhite, fontStyle: FontStyle.normal)),
                    ],
                  )),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            ProfileMenuWidget(
              title: 'Settings',
              icon: Icons.settings,
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
              },
            ),
            ProfileMenuWidget(
              title: 'History',
              icon: Icons.history,
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryScreen()));
              },
            ),
            ProfileMenuWidget(
              title: 'About Us',
              icon: Icons.app_settings_alt,
              onPress: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ProfileMenuWidget(
              title: 'Help',
              icon: Icons.question_mark,
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HelpScreen()));
              },
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ProfileMenuWidget(
              title: 'Logout',
              icon: Icons.logout,
              textColor: tdRed,
              onPress: () {
                FireAuth().logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.endIcon = true,
      this.textColor = Colors.black});
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.tealAccent.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: const Color.fromARGB(255, 0, 4, 3),
        ),
      ),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: Color.fromARGB(255, 4, 0, 0),
        ),
      ),
    );
  }
}
