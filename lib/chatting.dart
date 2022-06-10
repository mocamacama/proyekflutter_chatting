import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyek_chatting/dataclass.dart';

import 'dbserices.dart';
import 'globals.dart' as globals;

class ChattingClass extends StatefulWidget {
  const ChattingClass({Key? key}) : super(key: key);

  @override
  State<ChattingClass> createState() => _ChattingClassState();
}

class _ChattingClassState extends State<ChattingClass> {
  int _jumlah = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController txtChat = TextEditingController();
  String usernamesrc = "romario";
  String usernamedest = "romariocoba";
  String channel = "";

  _ChatState() {
    // String usernamesrc = globals.usernameses;
    channel = this.usernamesrc + this.usernamedest;
  }

  void sendmessage() async {
    var teks = txtChat.text;
    txtChat.text = "";

    DocumentReference ref = await _firestore
        .collection(channel)
        .add({'user1': usernamesrc, 'user2': usernamedest, 'teks': teks, 'tanggal': DateTime.now().toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("CHATTING"),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Database.getDataChatting(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("ERROR");
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      var snapdata = snapshot.data;
                      return ListView.separated(
                          itemBuilder: ((context, index) {
                            DocumentSnapshot dsData = snapshot.data!.docs[index];
                            String lvjudul = dsData['username'];
                            String lvisi = dsData['text'];
                            _jumlah = snapdata!.docs.length;
                            if (dsData['username'] == "romario") {
                              return ListTile(
                                onTap: () {
                                  // final dtBaru = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi + "+");
                                  // Database.ubahData(item: dtBaru);
                                  // final dtkirim = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => detData(
                                  //               dataDet: dtkirim,
                                  //             )));
                                },
                                onLongPress: () {
                                  Database.deleteData(judul: lvjudul);
                                },
                                title: Text(lvjudul),
                                subtitle: Text(lvisi),
                                tileColor: Colors.green,
                                contentPadding: EdgeInsets.all(0),
                              );
                            } else {
                              return ListTile(
                                onTap: () {
                                  // final dtBaru = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi + "+");
                                  // Database.ubahData(item: dtBaru);
                                  // final dtkirim = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => detData(
                                  //               dataDet: dtkirim,
                                  //             )));
                                },
                                onLongPress: () {
                                  Database.deleteData(judul: lvjudul);
                                },
                                title: Text(lvjudul),
                                subtitle: Text(lvisi),
                              );
                            }
                          }),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 8.0,
                              ),
                          itemCount: snapdata!.docs.length);
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                TextFormField(
                  controller: txtChat,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                ElevatedButton(onPressed: () {}, child: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
