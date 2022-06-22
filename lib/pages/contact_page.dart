import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:proyek_chatting/dataclass.dart';
import 'package:proyek_chatting/globals.dart';
import '../addfriend.dart';
import '../coba.dart';
import '../dbserices.dart';
import '../update_delete_friendlist.dart';
import 'package:proyek_chatting/globals.dart' as glb;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addFriend()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchFriend,
              decoration: InputDecoration(
                labelText: "Search Friend",
                hintText: "Case Sensitive",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue)),
              ),
            ),
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
                          return ListTile(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            leading: ProfilePicture(
                              name: lvUsername,
                              radius: 24,
                              fontsize: 18,
                            ),
                            trailing: GestureDetector(
                              child: const Icon(
                                Icons.chat,
                                size: 34,
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
                            ),
                            tileColor: const Color.fromARGB(255, 142, 221, 250),
                            dense: false,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => updateFriend(
                                    dataUsername: lvUsername,
                                    dataIdNum: lvIdNum,
                                  ),
                                ),
                              );
                            },
                            title: Text(
                              lvUsername,
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Raleway',
                                  color: Color.fromARGB(255, 2, 65, 110)),
                            ),
                            subtitle: Text(
                              lvIdNum,
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
