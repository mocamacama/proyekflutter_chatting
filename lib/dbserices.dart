import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyek_chatting/auth_service.dart';
import 'dataclass.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as glb;

final AuthenticationService _auth = AuthenticationService();
String _uid = _auth.getCurrentUser();

CollectionReference tblCatatan =
    FirebaseFirestore.instance.collection("tblChats");

// ---------------------- Sandro ---------------------//
var currentUser = FirebaseAuth.instance.currentUser;
CollectionReference tabelTeman = FirebaseFirestore.instance
    .collection("User")
    .doc(currentUser?.uid.toString())
    .collection("teman");

CollectionReference tabelUser = FirebaseFirestore.instance.collection("User");

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
    return await userList
        .doc(uid)
        .set({'uid': uid, 'name': name, 'email': email});
  }

// ---------------------- Sandro ---------------------//
  static Stream<QuerySnapshot> getData(String username, String? userId) {
    tabelTeman = FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .collection("teman");
    if (username == "") {
      return tabelTeman.snapshots();
    } else {
      return tabelTeman
          .orderBy("name")
          .startAt([username]).endAt([username + '\uf8ff']).snapshots();
      // .where("username", isGreaterThan: username).where("username", isLessThanOrEqualTo: username + '\uf8ff');
    }
  }

  Future<int> updateData({required dataUser user}) async {
    if (user.idNum != "") {
      var tmp = tabelTeman.where("email", isEqualTo: user.idNum);
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
      var tmp = tabelTeman.where("email", isEqualTo: user.idNum);
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

  Future<int> tambahData(
      {required dataUser user, required String? userId}) async {
    if (user.idNum != "") {
      var tmp = tabelUser.where("email", isEqualTo: user.idNum);
      final temp = await tmp.get();
      var tmp3 = tabelTeman.where("email", isEqualTo: user.idNum);
      final temp3 = await tmp3.get();

      final AuthenticationService _auth = AuthenticationService();
      String? _email = _auth.getCurrentEmail();
      if (temp.size > 0) {
        // print("temp2 size : " + temp2.size.toString());
        print("temp3 size : " + temp3.size.toString());
        if (_email == user.idNum) {
          return 3;
        }
        if (temp3.size == 1) {
          return 4;
        }

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

  // Future<int> registerUser({required dataUser user}) async {
  //   if (user.idNum != "") {
  //     var tmp = tabelUser.where("idNum", isEqualTo: user.idNum);
  //     final temp = await tmp.get();
  //     // print(temp.size);
  //     if (temp.size > 0) {
  //       DocumentReference docRef = tabelTeman.doc(user.idNum);
  //       await docRef
  //           .set(user.toJson())
  //           .whenComplete(() => print("User Berhasil Ditambahkan "))
  //           .catchError((e) => print(e));
  //       return 1;
  //     } else {
  //       print("User yang anda add tidak di temukan");
  //       return 0;
  //     }
  //   } else {
  //     print("User idNum kosong");
  //     return 0;
  //   }
  // }

// ---------------------- Sandro ---------------------//
}
