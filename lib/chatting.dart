import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyek_chatting/dataclass.dart';

import 'dbserices.dart';
import 'globals.dart' as globals;

class ChattingClass extends StatefulWidget {
  const ChattingClass() : super();

  @override
  State<ChattingClass> createState() => _ChattingClassState();
}

class _ChattingClassState extends State<ChattingClass> {
//   int _jumlah = 0;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController txtChat = TextEditingController();
//   String username1 = "romario";
//   String username2 = "romariocoba";
//   String channel = "";

//   _ChattingClassState() {
//     // String usernamesrc = globals.usernameses;
//     if (this.username1.compareTo(this.username2) < 0) {
//       channel = this.username1 + this.username2;
//     } else {
//       channel = this.username2 + this.username1;
//     }
//   }

//   void sendmessage() async {
//     var teks = txtChat.text;
//     txtChat.text = "";

//     DocumentReference ref = await _firestore
//         .collection(channel)
//         .add({'user1': username1, 'user2': username2, 'teks': teks, 'tanggal': DateTime.now().toString()});
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("CHATTING"),
            Expanded(
                // child: _buildBody(context)
                child: Column(
              children: [Text("asd")],
            )),
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

//   Widget _buildBody(BuildContext context) {
//     FirebaseFirestore.instance.collection(channel).get().then((QuerySnapshot snapshot) {
//       snapshot.docs.forEach((f) => print('${f.data}}'));
//     });

//     var data = FirebaseFirestore.instance.collection(channel).orderBy('tanggal').snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: data,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData)
//           return Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
//             ),
//           );
//         return _buildList(context, snapshot.data!.docs);
//         // return Expanded(
//         //   child: Row(),
//         // );
//       },
//     );
//   }

//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return Expanded(
//       child: ListView(
//         padding: const EdgeInsets.only(top: 20.0),
//         children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//       ),
//     );
//   }

//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final record = Record.fromSnapshot(data);
//     print("cek = " + record.user1 + "-" + "Romario");
//     if (record.user1 == username1) {
//       // rata kanan
//       return Padding(
//         key: ValueKey(record.tanggal),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 16.0,
//               ),
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//               child: Text(record.teks,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                   )),
//             ),
//             Padding(padding: const EdgeInsets.only(top: 5.0)),
//             Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
//             Padding(padding: const EdgeInsets.only(top: 10.0)),
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         key: ValueKey(record.tanggal),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 16.0,
//               ),
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//               child: Text(record.teks,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                   )),
//             ),
//             Padding(padding: const EdgeInsets.only(top: 5.0)),
//             Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
//             Padding(padding: const EdgeInsets.only(top: 10.0)),
//           ],
//         ),
//       );
//     }
//   }
// }

// class Record {
//   final String user1;
//   final String user2;
//   final String teks;
//   final String tanggal;
//   final DocumentReference reference;

//   Record.fromMap(Map<String, dynamic> map, {required this.reference})
//       : assert(map['user1'] != null),
//         assert(map['user2'] != null),
//         assert(map['teks'] != null),
//         assert(map['tanggal'] != null),
//         user1 = map['user1'],
//         user2 = map['user2'],
//         teks = map['teks'],
//         tanggal = map['tanggal'];

//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

//   @override
//   String toString() => "Record<$user1:$user2:$teks:$tanggal>";
// }
