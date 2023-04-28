import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodproject/view/color.dart';
import 'package:foodproject/view/profile_pages/about.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//
class Profile1 extends StatelessWidget {
  const Profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: 60,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(),
              ),
            ),
            const SizedBox(height: 30),
            Text('Test', style: Theme.of(context).textTheme.headlineMedium),
            Text('test@gmail.com',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    side: BorderSide.none,
                    elevation: 0,
                    shape: const StadiumBorder()),
                child: const Text('Edit Profile',
                    style: TextStyle(color: tdWhite)),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            ProfileMenuWidget(
              title: 'Settings',
              icon: Icons.settings,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: 'History',
              icon: Icons.history,
              onPress: () {},
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
              onPress: () {},
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ProfileMenuWidget(
              title: 'Logout',
              icon: Icons.logout,
              textColor: tdRed,
              onPress: () {},
            ),
            // ProfileMenuWidget(
            //   title: "Sign Out",
            //   icon: LineAwesomeIcons.alternate_sign_out,
            //   textColor: Colors.red,
            //   endIcon: false,
            //   onPress: () {},
            // ),
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
          color: Color.fromARGB(255, 0, 4, 3),
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
