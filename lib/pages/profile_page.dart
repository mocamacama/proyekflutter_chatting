import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/dbserices.dart';

import '../auth_service.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

final AuthenticationService _auth = AuthenticationService();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Future<String> getUserName() async {
  String _uid = _auth.getCurrentUser();
  String name = "";
  if (_uid != null) {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(_uid)
        .get()
        .then((ds) {
      name = ds.data()!['name'];
    }).catchError((e) => print(e));
  } else {}

  return name;
}

class _ProfilePageState extends State<ProfilePage> {
  final Database test = Database();
  late Future<String> _value;

  @override
  initState() {
    super.initState();
    _value = getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<String>(
              future: _value,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfilePicture(
                          name: snapshot.data.toString(),
                          radius: 50,
                          fontsize: 21),
                      SizedBox(height: 50),
                      //welcome
                      Text(snapshot.data.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          var currentUser = FirebaseAuth.instance.currentUser;
                          await _auth.signOut().then((result) {
                            print(currentUser?.uid);
                            Navigator.of(context).pop(true);
                          });
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                          size: 50,
                        ),
                      )
                    ]);
              }),
        ),
      ),
    );
  }
}
