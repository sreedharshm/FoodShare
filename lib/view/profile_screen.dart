
import 'package:flutter/material.dart';

class CustomerProfilePage extends StatefulWidget {
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'user@mail.com',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Donations',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '50',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green[600],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Favorite Charities',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Charity 1\nCharity 2\nCharity 3',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}