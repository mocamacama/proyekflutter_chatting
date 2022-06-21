// ignore_for_file: file_names, camel_case_types
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dataclass.dart';
import 'dbserices.dart';

class addFriend extends StatefulWidget {
  const addFriend({Key? key}) : super(key: key);

  @override
  State<addFriend> createState() => _addFriendState();
}

class _addFriendState extends State<addFriend> {
  final _idNumCtl = TextEditingController();
  final _usernameCtl = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _idNumCtl.dispose();
    _usernameCtl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<int> onAddFriend() async {
    setState(() {});
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser?.uid);
    final dataUser test =
        dataUser(idNum: _idNumCtl.text, username: _usernameCtl.text);
    int count =
        await Database().tambahData(user: test, userId: currentUser?.uid);
    // print("count : " + count.toString());
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Friend"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildUsername(),
            const SizedBox(
              height: 10,
            ),
            buildIdNumber(),
            const SizedBox(
              height: 40,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                setState(() {
                  _idNumCtl.text.isEmpty ? _validate = true : _validate = false;
                  _usernameCtl.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
                int co = 0;
                if (_validate) {
                  co = 2;
                } else {
                  co = await onAddFriend();
                }
                String _title = "Pemberitahuan";
                String _contentText = "";
                print(co);
                print(_validate);
                if (co == 1) {
                  _contentText = "Data berhasil ditambah";
                } else if (co == 2) {
                  _contentText = "Semua kolom harus di isi";
                } else if (co == 3) {
                  _contentText =
                      "Masukan user lain / tidak bisa menambah diri sendiri";
                } else if (co == 4) {
                  _contentText = "Sudah ada di contact";
                } else {
                  _contentText = "User tidak ditemukan";
                }
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(_title),
                          content: Text(_contentText),
                          actions: <Widget>[
                            MaterialButton(
                                elevation: 5.00,
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (co == 1) Navigator.pop(context);
                                })
                          ],
                        ));
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Friend"),
              backgroundColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  Widget buildIdNumber() => TextField(
      controller: _idNumCtl,
      decoration: InputDecoration(
        hintText: "example@gmail.com",
        labelText: "Email",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.phone_android),
        errorText: _validate ? 'Value Can\'t Be Empty' : null,
      ));

  Widget buildUsername() => TextField(
      controller: _usernameCtl,
      decoration: InputDecoration(
        hintText: "bang",
        labelText: "Name",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person_add),
        errorText: _validate ? 'Value Can\'t Be Empty' : null,
      ));
}
