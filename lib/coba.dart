// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, use_function_type_syntax_for_parameters

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class COBAA extends StatefulWidget {
  final String username1;
  final String username2;
  const COBAA({Key? key, required this.username1, required this.username2}) : super(key: key);

  @override
  State<COBAA> createState() => _COBAAState(this.username1, this.username2);
}

class _COBAAState extends State<COBAA> {
  TextEditingController txtChat = TextEditingController();
  ScrollController _lvcontroller = ScrollController();
  String username1, username2;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String channel = "";

  late FirebaseStorage _firebaseStorage;
  ImagePicker imgpicker = ImagePicker();
  XFile? _image;

  _COBAAState(this.username1, this.username2) {}

  @override
  void initState() {
    _firebaseStorage = FirebaseStorage.instance;
    if (this.username1.compareTo(this.username2) < 0) {
      channel = this.username1 + this.username2;
    } else {
      channel = this.username2 + this.username1;
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_lvcontroller.hasClients) {}
      Timer(Duration(seconds: 1), () {
        _lvcontroller.animateTo(
          _lvcontroller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
        );
      });
    });
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if (_lvcontroller.hasClients) {
    //     _lvcontroller.animateTo(
    //       _lvcontroller.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 10),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _lvcontroller.dispose();
    txtChat.dispose();
    super.dispose();
  }

  void fromCamera() async {
    var file = File("");
    await Permission.camera.request();
    var permissionStatus = await Permission.camera.status;
    var image = await imgpicker.pickImage(source: ImageSource.camera);
    image == null
        ? setState(() {
            SnackBar(content: Text("no img picked"));
          })
        : setState(() {
            _image = image;
            file = File(_image!.path);
          });
    if (image != null) {
      var filename = basename(file.path);
      // var snapshot =
      //     await _firebaseStorage.ref().child('images/$filename').putFile(file);
      Reference firebaseStorageRef = _firebaseStorage.ref().child('images/$filename');
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      var taskSnap = await (await uploadTask).ref.getDownloadURL();
      print(taskSnap);
      DocumentReference ref = await _firestore.collection(channel).add({
        'user1': username1,
        'user2': username2,
        'teks': "",
        'tanggal': DateTime.now().toString(),
        'gambar': taskSnap
      });
      _lvcontroller.jumpTo(_lvcontroller.position.maxScrollExtent);
      var currentUser = FirebaseAuth.instance.currentUser;
      print(currentUser?.uid);
      var lasmsgref = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .collection('teman')
          .doc(username2)
          .update({'lastmsg': "[Picture]"});

      var satunya = await _firestore.collection('User').where('email', isEqualTo: username2).get();
      final allData = satunya.docs.map((doc) => doc.data()).toList();
      var datachat = allData.last as Map<String, dynamic>;
      print("datachat:");
      print(datachat['uid']);
      var upsatunya = await FirebaseFirestore.instance
          .collection('User')
          .doc(datachat['uid'])
          .collection('teman')
          .doc(username1)
          .set({'lastmsg': "[Picture]"}, SetOptions(merge: true));
    }
  }

  uploadImage() async {
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);
      var filename = basename(file.path);
      if (image != null) {
        // //Upload to Firebase
        // var snapshot = await _firebaseStorage
        //     .ref()
        //     .child('images/$filename')
        //     .putFile(file); Reference firebaseStorageRef =
        Reference firebaseStorageRef = _firebaseStorage.ref().child('images/$filename');
        UploadTask uploadTask = firebaseStorageRef.putFile(file);
        var taskSnap = await (await uploadTask).ref.getDownloadURL();
        print(taskSnap);
        DocumentReference ref = await _firestore.collection(channel).add({
          'user1': username1,
          'user2': username2,
          'teks': "",
          'tanggal': DateTime.now().toString(),
          'gambar': taskSnap
        });
        _lvcontroller.jumpTo(_lvcontroller.position.maxScrollExtent);

        var currentUser = FirebaseAuth.instance.currentUser;
        print(currentUser?.uid);
        var lasmsgref = await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser?.uid)
            .collection('teman')
            .doc(username2)
            .update({'lastmsg': "[Picture]"});
        var satunya = await _firestore.collection('User').where('email', isEqualTo: username2).get();
        final allData = satunya.docs.map((doc) => doc.data()).toList();
        var datachat = allData.last as Map<String, dynamic>;
        print("datachat:");
        print(datachat['uid']);
        var upsatunya = await FirebaseFirestore.instance
            .collection('User')
            .doc(datachat['uid'])
            .collection('teman')
            .doc(username1)
            .set({
          'lastmsg': ["Picture"]
        }, SetOptions(merge: true));
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  void sendmessage() async {
    var teks = txtChat.text;
    txtChat.text = "";

    DocumentReference ref = await _firestore.collection(channel).add(
        {'user1': username1, 'user2': username2, 'teks': teks, 'tanggal': DateTime.now().toString(), 'gambar': ""});
    _lvcontroller.jumpTo(_lvcontroller.position.maxScrollExtent);
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser?.uid);
    var lasmsgref = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser?.uid)
        .collection('teman')
        .doc(username2)
        .update({'lastmsg': teks});
    var satunya = await _firestore.collection('User').where('email', isEqualTo: username2).get();
    final allData = satunya.docs.map((doc) => doc.data()).toList();
    var datachat = allData.last as Map<String, dynamic>;
    print("datachat:");
    print(datachat['uid']);
    var upsatunya = await FirebaseFirestore.instance
        .collection('User')
        .doc(datachat['uid'])
        .collection('teman')
        .doc(username1)
        .set({'lastmsg': teks}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: globals.warnaBackgroundLayar,
        appBar: AppBar(title: Text(this.username2)),
        body: Container(
          // color: globals.warnaBackgroundLayar,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildBody(context),
              ),
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        // ignore: unnecessary_new
                        new Flexible(
                          flex: 5,
                          child: TextFormField(
                            controller: txtChat,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Chat",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            fromCamera();
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            uploadImage();
                          },
                          child: Icon(
                            Icons.camera,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            sendmessage();
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.grey,
                          ),
                        ),

                        // child: FlatButton(
                        //   child: new Text("Send"),
                        //   onPressed: sendmessage,
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    FirebaseFirestore.instance.collection(channel).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => print('${f.data}}'));
    });

    var data = FirebaseFirestore.instance.collection(channel).orderBy('tanggal').snapshots();
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
      controller: _lvcontroller,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    print("cek = " + record.user1 + "-" + "Romario");
    if (record.user1 == username1) {
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
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
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
            Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
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
                decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10.0)),
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
            Text(record.tanggal.substring(0, 16) + "", style: TextStyle(fontSize: 10.0, color: Colors.black)),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
          ],
        ),
      );
    }
  }
}

class Record {
  final String user1;
  final String user2;
  final String teks;
  final String tanggal;
  final String gambar;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['user1'] != null),
        assert(map['user2'] != null),
        assert(map['teks'] != null),
        assert(map['tanggal'] != null),
        assert(map['gambar'] != null),
        user1 = map['user1'],
        user2 = map['user2'],
        teks = map['teks'],
        tanggal = map['tanggal'],
        gambar = map['gambar'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Record<$user1:$user2:$teks:$tanggal:$gambar>";
}
