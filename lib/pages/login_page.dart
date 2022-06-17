import 'package:flutter/material.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Center(
                child: Text(
              "SIGN IN",
              style: TextStyle(color: Colors.black),
            )),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Username
              inputText("Username"),
              SizedBox(height: 20),
              //Password
              inputText("Password"),
            ],
          ),
        ),
      ),
    );
  }

  Padding inputText(String hint) {
    if (hint == "Username") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            obscureText: true,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
          ),
        ),
      );
    }
  }
}
