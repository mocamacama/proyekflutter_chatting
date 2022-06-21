import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/chatting.dart';
import 'package:proyek_chatting/coba.dart';
import 'package:proyek_chatting/screen/home_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // String username1 = "romario1";
  // String username2 = "romario2";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // _jumlah++;
      //     // final dtBaru = itemCatatan(itemJudul: _jumlah.toString(), itemIsi: "333");
      //     // Database.tambahData(item: dtBaru);
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => COBAA(
      //                   username1: username1,
      //                   username2: username2,
      //                 )));
      //   },
      //   backgroundColor: Colors.blueGrey,
      //   child: Icon(
      //     Icons.chat_bubble,
      //     color: Colors.white,
      //     size: 32,
      //   ),
      // ),
    );
  }
}
