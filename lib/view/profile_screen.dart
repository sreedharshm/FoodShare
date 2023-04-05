import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//to commit
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Profile', style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(
                width: 120,
                height: 120,
                child: Icon(Icons.person_3_rounded),
              ),
<<<<<<< HEAD
              const SizedBox(height: 10),
              Text('Name', style: Theme.of(context).textTheme.headlineMedium),
              Text('Email', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Edit Profile')),
=======
              SizedBox(height: 10),
             Text('Name',style: Theme.of(context).textTheme.headlineMedium),
             Text('Email',style: Theme.of(context).textTheme.bodySmall),
             const SizedBox(height: 20),
             SizedBox(width: 200,
            // child: ElevatedButton(
             // onPressed: (){}, 
             // style: ElevatedButton.styleFrom(
              //  backgroundColor: Color(Colors.yellowAccent,side: BorderSide.none,shape:const StadiumBorder()),
           //  Text('Edit Profile')),

>>>>>>> d57c12dc6588a4d9bc6c45f518cdc4062c114a61
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
