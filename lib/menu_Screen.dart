
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test1/display_Profiles.dart';
import 'package:test1/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test1/add_profile.dart';

var name="";
var phone_no ="";
var adress="";
final _auth=FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;
CollectionReference profiles=FirebaseFirestore.instance.collection('Profiles');

Future<List> getStudentData()async{
  QuerySnapshot snapshot=await profiles.get();
  var profilesEdit=snapshot.docs.map((doc) => doc.data()).toList();
  return profilesEdit;
}

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Menu Screen"),
      ),
      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
              child:Text('Add Profiles'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddProfiles()),
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
              child:Text('Display Profiles'),
              onPressed: () async {
                var profiles= await getStudentData();
                print(profiles);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>DisplayProfiles(profiles)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}