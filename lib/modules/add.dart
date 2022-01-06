// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// import 'package:image_picker/image_picker.dart';
class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> doc =
      FirebaseFirestore.instance.collection('doc').snapshots();
  CollectionReference devData = FirebaseFirestore.instance.collection('doc');
  String valueText = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController desciptionController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  // ignore: unused_field
  var _img;

  Future addDeveloper() async {
    String username = usernameController.text;
    String email = emailController.text;
    String title = titleController.text;
    String desc = desciptionController.text;
    String day = dayController.text;

    return devData
        .add({
          'username': username,
          'email': email,
          'title': title,
          'description': desc,
          'day': day
        })
        .then((value) => print('Data added'))
        .catchError((e) => print('Failed to add $e'));
  }

  Future profilePick() async {
    // ImgSource source
    // var image = await ImagePickerGC.pickImage(
    //   context: context,
    //   source: source,
    // );
    // setState(() {
    //   _img = image;
    // });
  }

  Future getImage() async {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: doc,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storeDoc = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map one = document.data() as Map<String, dynamic>;
            storeDoc.add(one);
          }).toList();
          return Scaffold(
              body: AlertDialog(
            title: Text('Add your services'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          label: Text('Username'),
                          hintText: "Enter your username"),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: Text('Email'), hintText: "Enter your email"),
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          label: Text('Title'),
                          hintText: "I will do something I\'m really good"),
                    ),
                    TextFormField(
                      controller: desciptionController,
                      decoration: InputDecoration(
                          label: Text('Description'),
                          hintText: "Enter your description"),
                    ),
                    TextFormField(
                      controller: dayController,
                      decoration: InputDecoration(
                          label: Text('Days Completion'), hintText: "1 Day"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Profile Picture'),
                      onPressed: () => profilePick(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text('Upload your samples'),
                      onPressed: () => getImage,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text('SUBMIT'),
                onPressed: () {
                  setState(() {
                    addDeveloper();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ));
        });
  }
}
