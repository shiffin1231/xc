import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:test1/display_Profiles.dart';
import 'package:test1/menu_Screen.dart';
import 'package:test1/profiles.dart';

CollectionReference profile_ref =
FirebaseFirestore.instance.collection('Profiles');

Future<QuerySnapshot<Object?>> getStudentSnapshot() async {
  QuerySnapshot custSnapShot = await profile_ref.get();
  return (custSnapShot);
}

Future<List> getStudentData() async {
  QuerySnapshot snapshot = await profile_ref.get();
  var profiles_Edit = snapshot.docs.map((doc) => doc.data()).toList();
  return profiles_Edit;
}

class EditProfile extends StatefulWidget {
  final mobile;
  final name;
  final addrss;
  final index;

  EditProfile({this.index, this.mobile, this.name, this.addrss});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name;
    _address.text = widget.addrss;
    _phone.text = widget.mobile;

    return Scaffold(
        appBar: AppBar(
          title: Text('List View Builder'),
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightBlue,
                width: 5,
              )),
          child: Column(
            children: [
              buildTextField(controller: _nameController, name: "Name"),
              buildTextField(controller: _phone, name: "Phone"),
              buildTextField(controller: _address, name: "Address"),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlue)),
                  child: const Text('Update Details'),
                  onPressed: () async {
                    QuerySnapshot snapshot = await getStudentSnapshot();
                    dynamic docId = snapshot.docs[widget.index].id.toString();
                    var profiles_Edit = await getStudentData();
                    print(profiles_Edit);
                    {
                      if (_nameController.text.isEmpty ||
                          _phone.text.isEmpty ||
                          _address.text.isEmpty) {
                        print("fields are empty");
                      } else {
                        await profile_ref.doc(docId).update({
                          'name': _nameController.text,
                          'phone_no': _phone.text,
                          'adress': _address.text
                        });
                        var profiles_Edit = await getStudentData();

                        Navigator.pop(context);
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           DisplayProfiles(widget.profiles)),
                        // );
                      }
                    }
                  }),
            ],
          ),
        ));
  }

  Padding buildTextField({var controller, var name}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: name,
            //labelText: name,
          )),
    );
  }
