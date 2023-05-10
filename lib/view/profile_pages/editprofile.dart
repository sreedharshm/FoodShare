import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class edit_profile extends StatefulWidget {
  const edit_profile({super.key});

  @override
  State<edit_profile> createState() => edit_profileState();
}

class edit_profileState extends State<edit_profile> {
  late String _name;
  late String _email;
  late String _bio;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  
   @override
  void initState() {
    super.initState();

    _name ='';
    _email ='';
    _bio ='';

   _nameController.text = _name;
    _emailController.text = _email ;
    _bioController.text = _bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 130, 130, 130),
            fontSize: 20,
            fontWeight: FontWeight.normal),
        title: const Text("Edit Profile"),
      ),
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) => setState(() => _name = value),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (value) => setState(() => _email = value),
              ),
             const SizedBox(height: 16),
              TextField(
                controller: _bioController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                ),
                onChanged: (value) => setState(() => _bio = value),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}