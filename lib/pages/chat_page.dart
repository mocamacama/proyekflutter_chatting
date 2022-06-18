import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/chatting.dart';
import 'package:proyek_chatting/coba.dart';
import 'package:proyek_chatting/screen/home_screen.dart';
import 'package:proyek_chatting/dataclass.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String username1 = "0899";
  String username2 = "0812";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

/*@override
Widget build(BuildContext context) {
  return Scaffold(
      body: ListView.builder(
    itemCount: 25,
    itemBuilder: (BuildContext context, int index) {
      return Text("data");
    },
  ));
}

class Chat_List extends StatelessWidget {
  const Chat_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}*/
