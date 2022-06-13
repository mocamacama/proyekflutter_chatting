import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek_chatting/chatting.dart';
import 'package:proyek_chatting/coba.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Chatting",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username1 = "romario1";
  String username2 = "romario2";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatting")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _jumlah++;
          // final dtBaru = itemCatatan(itemJudul: _jumlah.toString(), itemIsi: "333");
          // Database.tambahData(item: dtBaru);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => COBAA(
                        username1: username1,
                        username2: username2,
                      )));
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
        child: Column(
          children: [
            TextField(
              // controller: ctrSearch,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: onSearch(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text("ERROR");
            //       } else {
            //         if (snapshot.hasData && snapshot.data != null) {
            //           var snapdata = snapshot.data;
            //           return ListView.separated(
            //               itemBuilder: ((context, index) {
            //                 DocumentSnapshot dsData = snapshot.data!.docs[index];
            //                 String lvjudul = dsData['judulCat'];
            //                 String lvisi = dsData['isiCat'];
            //                 _jumlah = snapdata!.docs.length;
            //                 return ListTile(
            //                   onTap: () {
            //                     // final dtBaru = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi + "+");
            //                     // Database.ubahData(item: dtBaru);
            //                     final dtkirim = itemCatatan(itemJudul: lvjudul, itemIsi: lvisi);
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) => detData(
            //                                   dataDet: dtkirim,
            //                                 )));
            //                   },
            //                   onLongPress: () {
            //                     Database.deleteData(judul: lvjudul);
            //                   },
            //                   title: Text(lvjudul),
            //                   subtitle: Text(lvisi),
            //                 );
            //               }),
            //               separatorBuilder: (context, index) => SizedBox(
            //                     height: 8.0,
            //                   ),
            //               itemCount: snapdata!.docs.length);
            //         }
            //         return Center(
            //           child: CircularProgressIndicator(
            //             valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
