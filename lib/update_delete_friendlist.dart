// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';

import 'dataclass.dart';
import 'dbserices.dart';

class updateFriend extends StatefulWidget {
  const updateFriend(
      {Key? key, required this.dataIdNum, required this.dataUsername})
      : super(key: key);
  final String dataIdNum;
  final String dataUsername;
  @override
  State<updateFriend> createState() =>
      // ignore: no_logic_in_create_state
      _updateFriend(dataIdNum_: dataIdNum, dataUsername_: dataUsername);
}

class _updateFriend extends State<updateFriend> {
  _updateFriend({required this.dataIdNum_, required this.dataUsername_});
  final String dataIdNum_;
  final String dataUsername_;
  final _usernameCtl = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _usernameCtl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<int> onUpdateFriend() async {
    setState(() {});
    final dataUser test =
        dataUser(idNum: dataIdNum_, username: _usernameCtl.text);
    // blm buat update database
    int count = await Database().updateData(user: test);
    // print("count : " + count.toString());
    return count;
  }

  Future<int> onDeleteFriend() async {
    setState(() {});
    final dataUser test =
        dataUser(idNum: dataIdNum_, username: _usernameCtl.text);
    // blm buat update database
    int count = await Database().deleteData(user: test);
    // print("count : " + count.toString());
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Friend"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildIdNumber(),
            const SizedBox(
              height: 10,
            ),
            buildUsername(),
            const SizedBox(
              height: 40,
            ),
            FloatingActionButton.extended(
              heroTag: "btnUpdate",
              onPressed: () async {
                setState(() {
                  _usernameCtl.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
                int co = 0;
                if (_validate) {
                  co = 2;
                } else {
                  co = await onUpdateFriend();
                }

                String _title = "Pemberitahuan";
                String _contentText = "";
                if (co == 1) {
                  _contentText = "Data berhasil diupdate";
                } else if (co == 2) {
                  _contentText = "Name harus di isi";
                } else {
                  _contentText = "Data gagal diupdate";
                }
                alertDialog(context, _title, _contentText, co);
              },
              icon: const Icon(Icons.update_rounded),
              label: const Text("Update Friend"),
              backgroundColor: Color.fromARGB(255, 43, 185, 32),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              heroTag: "btnDelete",
              onPressed: () async {
                int co = 0;
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: const Text("Peringatan !"),
                          content: const Text(
                              "Apakah anda yakin ingin menghapus teman ini ?"),
                          actions: <Widget>[
                            MaterialButton(
                                hoverColor: Color.fromARGB(251, 161, 169, 41),
                                color: Color.fromARGB(252, 184, 42, 42),
                                textColor: Colors.white,
                                elevation: 5.00,
                                child: const Text("Iya"),
                                onPressed: () async {
                                  co = await onDeleteFriend();
                                  Navigator.of(context).pop();
                                  String _title = "Pemberitahuan";
                                  String _contentText = "";
                                  if (co == 1) {
                                    _contentText = "Data berhasil dihapus";
                                  } else {
                                    _contentText = "Data gagal dihapus";
                                  }
                                  alertDialog(
                                      context, _title, _contentText, co);
                                }),
                            MaterialButton(
                                elevation: 5.00,
                                child: const Text("Tidak"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        ));
              },
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text("Delete Friend"),
              backgroundColor: Color.fromARGB(252, 184, 42, 42),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> alertDialog(
      BuildContext context, String _title, String _contentText, int co) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
  }

  Widget buildIdNumber() => TextFormField(
      readOnly: true,
      initialValue: dataIdNum_,
      decoration: InputDecoration(
        hintText: dataIdNum_,
        labelText: "ID Number",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.phone_android),
      ));

  Widget buildUsername() => TextFormField(
      autofocus: true,
      controller: _usernameCtl,
      decoration: InputDecoration(
        errorText: _validate ? 'Value Can\'t Be Empty' : null,
        hintText: dataUsername_,
        labelText: "Name",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person_add),
      ));
}
