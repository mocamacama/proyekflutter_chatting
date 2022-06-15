import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/chatting.dart';
import 'package:proyek_chatting/coba.dart';
import 'package:proyek_chatting/screen/home_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Chatting",
    home: HomeScreen(),
  ));
}

class Chat_app extends StatelessWidget {
  const Chat_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Chat App", home: HomeScreen());
  }
}
