import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dbserices.dart';

class ChattingClass extends StatefulWidget {
  const ChattingClass({Key? key}) : super(key: key);

  @override
  State<ChattingClass> createState() => _ChattingClassState();
}

class _ChattingClassState extends State<ChattingClass> {
  int _jumlah = 0;
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
          ],
        ),
      ),
    );
  }
}
