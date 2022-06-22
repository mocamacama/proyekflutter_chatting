import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:proyek_chatting/chatting.dart';
import 'package:proyek_chatting/coba.dart';
import 'package:proyek_chatting/dbserices.dart';
import 'package:proyek_chatting/screen/home_screen.dart';
import 'package:proyek_chatting/globals.dart' as glb;
import 'package:proyek_chatting/dataclass.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // String username1 = "0899";
  // String username2 = "0812";

  final _searchFriend = TextEditingController();
  String channel = "";
  @override
  void dispose() {
    _searchFriend.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchFriend.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser?.uid);
    return Database.getData(_searchFriend.text, currentUser?.uid);
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
      //                   username1: "0899",
      //                   username2: "0812",
      //                 )));
      //   },
      //   backgroundColor: Colors.blueGrey,
      //   child: Icon(
      //     Icons.chat_bubble,
      //     color: Colors.white,
      //     size: 32,
      //   ),
      // ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TextField(
            //   controller: _searchFriend,
            //   decoration: InputDecoration(
            //     labelText: "Search Friend",
            //     hintText: "Case Sensitive",
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.blue)),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Snapshot Has an ERROR');
                    // ignore: unrelated_type_equality_checks
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsDataFriends =
                              snapshot.data!.docs[index];
                          String lvUsername = dsDataFriends['name'];
                          String lvIdNum = dsDataFriends['email'];
                          String lvLastmsg = dsDataFriends['lastmsg'];
                          return ListTile(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            leading: ProfilePicture(
                              name: lvUsername,
                              radius: 24,
                              fontsize: 18,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => COBAA(
                                          username1: glb.usernameses,
                                          username2: lvIdNum,
                                        )),
                              );
                            },
                            tileColor: Color.fromARGB(255, 110, 216, 174),
                            dense: false,
                            title: Text(
                              lvUsername,
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Raleway',
                                  color: Color.fromARGB(255, 2, 65, 110)),
                            ),
                            subtitle: Text(
                              lvLastmsg,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8.0),
                        itemCount: snapshot.data!.docs.length);
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pinkAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  CollectionReference tabelTeman = FirebaseFirestore.instance
      .collection("tabelUser")
      .doc(glb.usernameses)
      .collection("teman");

  tabelTeman.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((f) => print('${f.data}}'));
  });

  var data = tabelTeman.orderBy('tanggal').snapshots();
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
      // return Text("asd");
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  print("cek = " + record.user1 + "-" + "Romario");
  if (record.user1 == "lasmsg") {
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
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0)),
              child: record.gambar == ""
                  ? Text(record.teks,
                      style: TextStyle(
                        fontSize: 20.0,
                      ))
                  : Image.network(
                      record.gambar,
                      width: 80,
                      height: 100,
                    )),
          Padding(padding: const EdgeInsets.only(top: 5.0)),
          Text(record.tanggal.substring(0, 16) + "",
              style: TextStyle(fontSize: 10.0, color: Colors.black)),
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
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0)),
              child: record.gambar == ""
                  ? Text(record.teks,
                      style: TextStyle(
                        fontSize: 20.0,
                      ))
                  : Image.network(
                      record.gambar,
                      width: 80,
                      height: 100,
                    )),
          Padding(padding: const EdgeInsets.only(top: 5.0)),
          Text(record.tanggal.substring(0, 16) + "",
              style: TextStyle(fontSize: 10.0, color: Colors.black)),
          Padding(padding: const EdgeInsets.only(top: 10.0)),
        ],
      ),
    );
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
