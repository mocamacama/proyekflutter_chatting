// ignore_for_file: no_logic_in_create_state

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class COBAA extends StatefulWidget {
  final String username1;
  final String username2;
  const COBAA({Key? key, required this.username1, required this.username2}) : super(key: key);

  @override
  State<COBAA> createState() => _COBAAState(this.username1, this.username2);
}

class _COBAAState extends State<COBAA> {
  TextEditingController txtChat = TextEditingController();
  String username1, username2;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String channel = "";

  _COBAAState(this.username1, this.username2) {
    if (this.username1.compareTo(this.username2) < 0) {
      channel = this.username1 + this.username2;
    } else {
      channel = this.username2 + this.username1;
    }
  }

  File? imageFile;
  ImagePicker _picker = ImagePicker();

  Future getImage() async{
    await _picker.pickImage(source: ImageSource.gallery).then((XFile){

      if(XFile != null ){
        imageFile = File(xFile.path);
      }

    })
  }

  void sendmessage() async {
    var teks = txtChat.text;
    txtChat.text = "";

    DocumentReference ref = await _firestore
        .collection(channel)
        .add({'user1': username1, 'user2': username2, 'teks': teks, 'tanggal': DateTime.now().toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: globals.warnaBackgroundLayar,
        appBar: AppBar(title: Text(this.username2)),
        body: Container(
          // color: globals.warnaBackgroundLayar,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildBody(context),
              ),
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller: txtChat,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Chat",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              sendmessage();
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                          ),
                          // child: FlatButton(
                          //   child: new Text("Send"),
                          //   onPressed: sendmessage,
                          // )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    FirebaseFirestore.instance.collection(channel).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => print('${f.data}}'));
    });

    var data = FirebaseFirestore.instance.collection(channel).orderBy('tanggal').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: data,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          );
        return _buildList(context, snapshot.data!.docs);
        // return Expanded(
        //   child: Row(),
        // );
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    print("cek = " + record.user1 + "-" + "Romario");
    if (record.user1 == username1) {
      // rata kanan
      return Padding(
        key: ValueKey(record.tanggal),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
              child: Text(record.teks,
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
            ),
            Padding(padding: const EdgeInsets.only(top: 5.0)),
            Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
          ],
        ),
      );
    } else {
      return Padding(
        key: ValueKey(record.tanggal),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
              child: Text(record.teks,
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
            ),
            Padding(padding: const EdgeInsets.only(top: 5.0)),
            Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
          ],
        ),
      );
    }
  }
}

class Record {
  final String user1;
  final String user2;
  final String teks;
  final String tanggal;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['user1'] != null),
        assert(map['user2'] != null),
        assert(map['teks'] != null),
        assert(map['tanggal'] != null),
        assert(map['gambar'] != null),
        user1 = map['user1'],
        user2 = map['user2'],
        teks = map['teks'],
        tanggal = map['tanggal'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Record<$user1:$user2:$teks:$tanggal:>";
}
