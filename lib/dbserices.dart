import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_chatting/auth_service.dart';
import 'dataclass.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as glb;

CollectionReference tblCatatan =
    FirebaseFirestore.instance.collection("tblChats");

// ---------------------- Sandro ---------------------//
CollectionReference tabelTeman = FirebaseFirestore.instance
    .collection("tabelUser")
    .doc(glb.usernameses)
    .collection("teman");

CollectionReference tabelUser =
    FirebaseFirestore.instance.collection("tabelUser");
// ------------------------------------------------------//

class Database {
  // static Stream<QuerySnapshot> getData(String judul) {
  //   if (judul == "") {
  //     return tblCatatan.snapshots();
  //   } else {
  //     return tblCatatan
  //         // .where("judulCat", isEqualTo: judul)

  //         .orderBy('judulCat')
  //         .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  //   }

  //   // CollectionReference tblCatatan = FirebaseFirestore.instance.collection("tabelcatatan");
  //   // tblCatatan.snapshots().listen(
  //   //         (event) => print("current data: ${event.data()}"),
  //   //         onError: (error) => print("Listen failed: $error"),
  //   //       );
  // }

  // static Future<Stream<QuerySnapshot<Object?>>> sendChat(
  //     {required itemChats item}) async {
  //   DocumentReference docRef = tblCatatan.doc();

  //   await docRef
  //       .set(item.toJson())
  //       .whenComplete(() => print("chat berhasil di-input"))
  //       .catchError((e) => print(e));

  //   return tblCatatan.snapshots();
  // }

  // static Stream<QuerySnapshot> getDataChatting() {
  //   return tblCatatan.snapshots();
  // }

  // static Future<void> tambahData({required itemCatatan item}) async {
  //   DocumentReference docRef = tblCatatan.doc(item.itemJudul);

  //   await docRef
  //       .set(item.toJson())
  //       .whenComplete(() => print("Data berhasil di-input"))
  //       .catchError((e) => print(e));
  // }

  // static Future<void> ubahData({required itemCatatan item}) async {
  //   DocumentReference docRef = tblCatatan.doc(item.itemJudul);

  //   await docRef
  //       .update(item.toJson())
  //       .whenComplete(() => print("Data berhasil diubah"))
  //       .catchError((e) => print(e));
  // }

  // static Future<void> deleteData({required String judul}) async {
  //   DocumentReference docRef = tblCatatan.doc(judul);

  //   await docRef
  //       .delete()
  //       .whenComplete(() => print("Data berhasil dihapus"))
  //       .catchError((e) => print(e));
  // }
//------------------------ML------------------------//
  final CollectionReference userList =
      FirebaseFirestore.instance.collection('User');

  Future<void> createUserData(String email, String name, String uid) async {
    return await userList.doc(uid).set({'name': name});
  }

  Future<String> getCurrentUser() async {
    String nama = "";
    final AuthenticationService _auth = AuthenticationService();
    String _uid = _auth.getCurrentUser();
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(_uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      nama = data?['name']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
    return nama;
  }

// ---------------------- Sandro ---------------------//
  static Stream<QuerySnapshot> getData(String username) {
    if (username == "") {
      return tabelTeman.snapshots();
    } else {
      return tabelTeman
          .orderBy("username")
          .startAt([username]).endAt([username + '\uf8ff']).snapshots();
      // .where("username", isGreaterThan: username).where("username", isLessThanOrEqualTo: username + '\uf8ff');
    }
  }

  Future<int> updateData({required dataUser user}) async {
    if (user.idNum != "") {
      var tmp = tabelTeman.where("idNum", isEqualTo: user.idNum);
      final temp = await tmp.get();
      if (temp.size > 0) {
        int tmp = 0;
        DocumentReference docRef = tabelTeman.doc(user.idNum);
        await docRef
            .update(user.toJson())
            .whenComplete(() => tmp = 1)
            .catchError((e) => print(e));
        return tmp;
      }
      return 0;
    } else {
      return 0;
    }
  }

  Future<int> deleteData({required dataUser user}) async {
    if (user.idNum != "") {
      var tmp = tabelTeman.where("idNum", isEqualTo: user.idNum);
      final temp = await tmp.get();
      if (temp.size > 0) {
        int tmp = 0;
        DocumentReference docRef = tabelTeman.doc(user.idNum);
        await docRef
            .delete()
            .whenComplete(() => tmp = 1)
            .catchError((e) => print(e));
        return tmp;
      }
      return 0;
    } else {
      return 0;
    }
  }

  Future<int> tambahData({required dataUser user}) async {
    if (user.idNum != "") {
      var tmp = tabelUser.where("idNum", isEqualTo: user.idNum);
      final temp = await tmp.get();
      // print(temp.size);
      if (temp.size > 0) {
        DocumentReference docRef = tabelTeman.doc(user.idNum);
        await docRef
            .set(user.toJson())
            .whenComplete(() => print("User Berhasil Ditambahkan "))
            .catchError((e) => print(e));
        return 1;
      } else {
        print("User yang anda add tidak di temukan");
        return 0;
      }
    } else {
      print("User idNum kosong");
      return 0;
    }
  }

  Future<int> registerUser({required dataUser user}) async {
    if (user.idNum != "") {
      var tmp = tabelUser.where("idNum", isEqualTo: user.idNum);
      final temp = await tmp.get();
      // print(temp.size);
      if (temp.size > 0) {
        DocumentReference docRef = tabelTeman.doc(user.idNum);
        await docRef
            .set(user.toJson())
            .whenComplete(() => print("User Berhasil Ditambahkan "))
            .catchError((e) => print(e));
        return 1;
      } else {
        print("User yang anda add tidak di temukan");
        return 0;
      }
    } else {
      print("User idNum kosong");
      return 0;
    }
  }

// ---------------------- Sandro ---------------------//
}
