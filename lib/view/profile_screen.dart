import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodproject/view/color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile1 extends StatelessWidget {
  const Profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),child: const Image(image: AssetImage('ProfileImage')),
              ),
            ),
            const SizedBox(height: 30),
            Text('ProfileHeading',style: Theme.of(context).textTheme.headlineMedium),
            Text('ProfileSubHeading',style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: (){},
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,side: BorderSide.none,shape: const StadiumBorder()),
                child: const Text('Edit Profile',style: TextStyle(color: tdBlack)),  
                 ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            ProfileMenuWidget(title: 'Settings',icon: LineAwesomeIcons.cog,onPress: (){},),
            ProfileMenuWidget(title: 'History',icon: LineAwesomeIcons.history,onPress: (){},),
            ProfileMenuWidget(title: 'App Details',icon: LineAwesomeIcons.user_check,onPress: (){},),
            ProfileMenuWidget(title: 'Help',icon: LineAwesomeIcons.question,onPress: (){},),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ProfileMenuWidget(title: 'Logout', icon : LineAwesomeIcons.info,onPress: (){},),
           // ProfileMenuWidget(
             // title: LineAwesomeIcons.alternate_sign_out,
              //textColor: Colors.red,
             // endIcon: false,
            //  onPress: () {},
           // ),

          ],
          ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor = Colors.black
  }); 
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
          borderRadius: BorderRadius.circular(100),
          color: Colors.tealAccent.withOpacity(0.1),
        ),
        child:  Icon(LineAwesomeIcons.cog,color: Colors.tealAccent,),
      ),
      title: Text('Settings',style: Theme.of(context).textTheme.bodyLarge),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(LineAwesomeIcons.angle_right,size: 18.0,color: Colors.grey,),
      ),
    );
  }
}