//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs
  // List<String> docIDs = [];

  // Future getDocId() async {
  //   await FirebaseFirestore.instance.collection('data').get().then(
  //         (snapshot) => snapshot.docs.forEach((document) {
  //           print(document.reference);
  //           docIDs.add(document.reference.id);
  //         }),
  //       );
  // }

  final databaseReference = FirebaseDatabase.instance.ref();

  String bottle = 'Loading...';
  bool isFull = false;
  String keytag = 'Loading...';

  @override
  void initState() {
    super.initState();
    databaseReference.child('Bottle').onValue.listen((event) {
      setState(() {
        bottle = event.snapshot.value.toString();
      });
    });
    databaseReference.child('IsFull').onValue.listen((event) {
      setState(() {
        isFull = event.snapshot.value as bool;
      });
    });
    databaseReference.child('Keytag').onValue.listen((event) {
      setState(() {
        keytag = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed in as : ' + user.email!),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Bottle: $bottle",
                    ),
                    Text(
                      "IsFull: $isFull",
                    ),
                    Text(
                      "Keytag: $keytag",
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.deepPurple[200],
            child: Text("Sign out"),
          ),
          SizedBox(
            height: 20,
          ),
          // Expanded(
          //     child: FutureBuilder(
          //         future: getDocId(),
          //         builder: (context, snapshot) {
          //           return ListView.builder(
          //             itemCount: docIDs.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text(docIDs[index]),
          //               );
          //             },
          //           );
          //         })),
        ],
      )),
    );
  }
}
