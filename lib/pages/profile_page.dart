import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/dbserices.dart';

import '../auth_service.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Database test = Database();
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ProfilePicture(name: '', radius: 31, fontsize: 21),
              SizedBox(height: 50),
              //welcome
              // Text(test.getCurrentUser().toString(),
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  await _auth.signOut().then((result) {
                    Navigator.of(context).pop(true);
                  });
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
