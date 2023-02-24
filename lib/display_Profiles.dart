import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/profiles.dart';
import 'edit_Profiles.dart';

var name = "";
var phone_no = "";
var adress = "";
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
List<Profiles> profiles = List.empty(growable: true);
CollectionReference profile_collection_ref = FirebaseFirestore.instance.collection('Profiles');

Future<List> getStudentData() async {
  QuerySnapshot snapshot = await profile_collection_ref.get();
  var profiles_Edit = snapshot.docs.map((doc) => doc.data()).toList();
  return profiles_Edit;
}

Future<QuerySnapshot> getStudentSnapshot() async {
  QuerySnapshot snapshot = await profile_collection_ref.get();
  return snapshot;
}

class DisplayProfiles extends StatefulWidget {
  DisplayProfiles(this.profiles);
  var profiles;

  @override
  _DisplayProfilesState createState() => _DisplayProfilesState();
}

class _DisplayProfilesState extends State<DisplayProfiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Profiles'),
    ),
    body: ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: widget.profiles.length,
    itemBuilder: (context, index) {
    return RefreshIndicator(
    onRefresh: getStudentData,
    child: GestureDetector(
    child: ListTile(
    leading: CircleAvatar(
    radius: 25,
    backgroundColor: Colors.lightBlue,
    foregroundColor: Colors.white,
    child: Text(
    widget.profiles[index]["name"][0].toString().toUpperCase(),
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(
    widget.profiles[index]["name"],
    style: TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Text(widget.profiles[index]["phone_no"]),
    ],
    ),
    subtitle: Text(
    widget.profiles[index]["adress"],
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    ),
    trailing: SizedBox(
    width: 70,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    InkWell(
    onTap: () async {
    dynamic profiles1 = [
    {
    "name": widget.profiles[index]["name"],
    "phone_no": widget
        .profiles[index]["phone_no"],
    "adress": widget.profiles[index]["adress"],
    },
    ];
    print(widget.profiles[index]);

    QuerySnapshot snapshot = await getStudentSnapshot();
    dynamic docId = snapshot.docs[index].id
        .toString();
    print("docId :${docId}");
    if (name.isEmpty || phone_no.isEmpty ||
    adress.isEmpty) {
    print("Enter fields are Empty");
    } else {
    await profile_collection_ref.doc(docId).update({
    'name': name,
    'phone_no': phone_no,
    'adress': adress
    });
    var profiles_Edit = await getStudentData();
    setState(() {
    widget.profiles = profiles_Edit;
    });
    name = "";
    phone_no = "";
    adress = "";
    }
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => EditProfile(
    index: index,
    name: widget.profiles[index]["name"],
    mobile: widget.profiles[index]["phone_no"],
    addrss: widget.profiles[index]["adress"],
    ),
    ),
    );
    },
    child: Icon(Icons.edit),
    ),
    SizedBox(
    width: 10,
    ),
    InkWell(
    onTap: () async {
    await profile_collection_ref
        .doc(widget.profiles[index]['id'])
        .delete();

    var profiles_Edit = await getStudentData();
    setState(() {
    widget.profiles = profiles_Edit;
    });
    },
    child: Icon(Icons.delete),
    ),
    ],
    ),
    ),),),
    );
    }
    ),
    );
  }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:test1/profiles.dart';
// import 'edit_Profiles.dart';
//
// var name = "";
// var phone_no = "";
// var adress = "";
// final _auth = FirebaseAuth.instance;
// final _firestore = FirebaseFirestore.instance;
// // var profiles="";
// List<Profiles> profiles = List.empty(growable: true);
// CollectionReference profile_collection_ref =
// FirebaseFirestore.instance.collection('Profiles');
// Future<List> getStudentData() async {
//   QuerySnapshot snapshot = await profile_collection_ref.get();
//   var profiles_Edit = snapshot.docs.map((doc) => doc.data()).toList();
//   return profiles_Edit;
// }
//
// class DisplayProfiles extends StatelessWidget {
//   DisplayProfiles(this.profiles);
//   var profiles;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlueAccent,
//         title: Text('Profiles'),
//       ),
//       body: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: profiles.length,
//         itemBuilder: (context, index) {
//           return RefreshIndicator(
//             onRefresh: getStudentData,
//             child: GestureDetector(
//               child: ListTile(
//                 leading: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Colors.lightBlue,
//                   foregroundColor: Colors.white,
//                   child: Text(
//                     profiles[index]["name"][0].toString().toUpperCase(),
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       profiles[index]["name"],
//                       style:
//                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(profiles[index]["phone_no"]),
//                   ],
//                 ),
//                 subtitle: Text(
//                   profiles[index]["adress"],
//                   style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: SizedBox(
//                   width: 70,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         InkWell(
//                             onTap: () async {
//                               dynamic profiles1 = [
//                                 {
//                                   "name": profiles[index]["name"],
//                                   "phone_no": profiles[index]["phone_no"],
//                                   "adress": profiles[index]["adress"],
//                                 },
//                               ];
//                               print(profiles[index]);
//
//                               QuerySnapshot snapshot =
//                               await getStudentSnapshot();
//                               dynamic docId =
//                               snapshot.docs[index].id.toString();
//                               print("docId :${docId}");
//                               if (name.isEmpty ||
//                                   phone_no.isEmpty ||
//                                   adress.isEmpty) {
//                                 print("Enter fields are Empty");
//                               } else {
//                                 await profile_collection_ref.doc(docId).update({
//                                   'name': name,
//                                   'phone_no': phone_no,
//                                   'adress': adress
//                                 });
//                                 var profiles_Edit = await getStudentData();
//                                 name = "";
//                                 phone_no = "";
//                                 adress = "";
//                               }
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => EditProfile(
//                                       index: index,
//                                       name: profiles[index]["name"],
//                                       mobile: profiles[index]["phone_no"],
//                                       addrss: profiles[index]["adress"],
//                                     )),
//                               );
//                             },
//                             child: Icon(Icons.edit)),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         InkWell(
//                             onTap: () async {
//                               // profile_collection_ref.child(profiles[index]).remove();
//                               profiles.removeAt(index);
//                               // var profiles = await getStudentData();
//                               var profiles_Edit = await getStudentData();
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DisplayProfiles(profiles)),
//                               );
//                               print(profiles_Edit);
//                               print(profiles[index]);
//
//                               // Navigator.push(context,
//                               //   MaterialPageRoute(
//                               //       builder: (context) => DisplayProfiles(profiles)),
//                               // );
//                             },
//                             child: Icon(Icons.delete)),
//                       ]),
//                 ),
//               ),
//             ),
//           );
//
//   }
}