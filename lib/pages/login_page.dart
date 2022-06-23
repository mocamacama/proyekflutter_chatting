import 'package:flutter/material.dart';
import 'package:proyek_chatting/auth_service.dart';
import 'package:proyek_chatting/screen/home_screen.dart';
import 'package:proyek_chatting/globals.dart' as glb;

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
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
              SizedBox(height: 20),
              //Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    obscureText: true,
                    controller: _passwordController,
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
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                        signInUser();
                      },
                      child: Text(
                        "Sign In",
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
    );
  }

  void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailContoller.text, _passwordController.text);
    if (authResult == null) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Pemberitahuan"),
                content: Text('Gagal Sign In, Password atau Email salah'),
                actions: <Widget>[
                  MaterialButton(
                      elevation: 5.00,
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ));
    } else {
      glb.usernameses = _emailContoller.text;
      _emailContoller.clear();
      _passwordController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
