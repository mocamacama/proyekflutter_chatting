// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/dbserices.dart';
import 'package:proyek_chatting/screen/welcome_screen.dart';
import '../dataclass.dart';
import 'package:proyek_chatting/auth_service.dart';

class Register_Page extends StatefulWidget {
  const Register_Page({Key? key}) : super(key: key);

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Form(
        key: _key,
        child: Center(
          child: Scaffold(
            appBar: AppBar(
              title: Text("SIGN UP"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _emailContoller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                //username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _nameContoller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                //Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          )),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                //register
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Container(
                      width: 1000,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            createUser();
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createUser() async {
    dynamic result = await _auth.createNewUser(_emailContoller.text, _nameContoller.text, _passwordController.text);
    // print("ini email" + result.email);
    if (result == null) {
      print('Email is not valid');
    } else {
      // CollectionReference users = FirebaseFirestore.instance.collection("User");
      // // String uid = _auth.getCurrentUser();
      // users.add({"name": _nameContoller.text, "password": _passwordController.text, "email": _emailContoller.text});
      print(result.toString());
      _emailContoller.clear();
      _passwordController.clear();
      Navigator.pop(context);
    }
  }
}
