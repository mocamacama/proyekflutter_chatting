import 'package:firebase_auth/firebase_auth.dart';

class itemCatatan {
  final String itemJudul;
  final String itemIsi;

  itemCatatan({required this.itemJudul, required this.itemIsi});

  Map<String, dynamic> toJson() {
    return {
      "judulCat": itemJudul,
      "isiCat": itemIsi,
    };
  }

  factory itemCatatan.fromJson(Map<String, dynamic> json) {
    return itemCatatan(itemJudul: json['judulCat'], itemIsi: json['isiCat']);
  }
}

class itemChats {
  final String username;
  final String text;
  final String waktu;

  itemChats({required this.username, required this.text, required this.waktu});

  Map<String, dynamic> toJson() {
    return {"username": username, "text": text, "waktu": waktu};
  }

  factory itemChats.fromJson(Map<String, dynamic> json) {
    return itemChats(username: json['username'], text: json['text'], waktu: json['waktu']);
  }
}

// ---------- Sandro -----------//
// ignore: camel_case_types
class dataUser {
  final String idNum;
  final String username;
  final String lastmsg = "";

  dataUser({
    required this.idNum,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {'email': idNum, 'name': username, 'lastmsg': lastmsg};
  }

  factory dataUser.fromJson(Map<String, dynamic> json) {
    return dataUser(idNum: json['email'], username: json['name']);
  }
}

class Users {
  final String username;
  final String password;
  final String email;
  Users(this.username, this.password, this.email);
}
