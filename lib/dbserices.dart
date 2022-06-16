import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dataclass.dart';
import 'package:intl/intl.dart';

CollectionReference tblCatatan =
    FirebaseFirestore.instance.collection("tblChats");

class Database {
  static Stream<QuerySnapshot> getData(String judul) {
    if (judul == "") {
      return tblCatatan.snapshots();
    } else {
      return tblCatatan
          // .where("judulCat", isEqualTo: judul)

          .orderBy('judulCat')
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
    }

    // CollectionReference tblCatatan = FirebaseFirestore.instance.collection("tabelcatatan");
    // tblCatatan.snapshots().listen(
    //         (event) => print("current data: ${event.data()}"),
    //         onError: (error) => print("Listen failed: $error"),
    //       );
  }

  static Future<Stream<QuerySnapshot<Object?>>> sendChat(
      {required itemChats item}) async {
    DocumentReference docRef = tblCatatan.doc();

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("chat berhasil di-input"))
        .catchError((e) => print(e));

    return tblCatatan.snapshots();
  }

  static Stream<QuerySnapshot> getDataChatting() {
    return tblCatatan.snapshots();
  }

  static Future<void> tambahData({required itemCatatan item}) async {
    DocumentReference docRef = tblCatatan.doc(item.itemJudul);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data berhasil di-input"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required itemCatatan item}) async {
    DocumentReference docRef = tblCatatan.doc(item.itemJudul);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("Data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required String judul}) async {
    DocumentReference docRef = tblCatatan.doc(judul);

    await docRef
        .delete()
        .whenComplete(() => print("Data berhasil dihapus"))
        .catchError((e) => print(e));
  }
}
