// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unique/widgets/mydrawer.dart';
// import 'package:unique/widgets/picturewidget.dart';
import 'loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  bool changeButton = false;
  int _selectedTab = 0;
  String codeDialog = '';
  String valueText = '';
  int _value = 1;
  TextEditingController _textFieldController = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('doc').snapshots();

  logout() async {
    setState(() {
      changeButton = true;
    });
    // ignore: unused_local_variable
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 1));
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Loginpage()));
  }

  // Future<void> _displayTextInputDialog(BuildContext context) async {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TabController tabController;
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: const Text('Get Services'),
              toolbarHeight: 66,
              actions: [
                IconButton(
                    onPressed: () {
                      if (firebaseUser != null) {
                        Navigator.pushNamed(context, '/add');
                        // _displayTextInputDialog(context);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                // ignore: unnecessary_brace_in_string_interps
                                content: Text(
                                  'Login here',
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  FlatButton(
                                      color: Colors.deepPurple,
                                      textColor: Colors.white,
                                      child: Text('LOGIN'),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      }),
                                ],
                              );
                            });
                      }
                    },
                    icon: Icon(Icons.add)),
                IconButton(onPressed: logout, icon: Icon(Icons.logout))
              ],
            ),
            drawer: MyDrawer(),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  Text(
                    'Find',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Developers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildHeader(context),
                  SizedBox(
                    height: 10,
                  ),
                  _buildSearch(),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Developers",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "View More",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: builtPicture(
                                "assets/images/img2.jpg",
                                data['username'],
                              ),
                            ),
                          ],
                          // title: Text(data['username']),
                          // subtitle: Text(data['email']),
                        ),
                      );
                    }).toList(),
                  ),
                ])),
          );
          //           Row(
          //             children: [
          //               InkWell(
          //                 onTap: () {
          //                   print('First print');
          //                 },

          //               InkWell(
          //                 child: builtPicture(
          //                   "assets/images/img3.jpg",
          //                   "Shane West",
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 24,
          //           ),
          //         ]),
          //         SizedBox(
          //           height: 24,
          //         ),

          //       ],
          //     ),
          //   ),
          // );
        });
  }
}

Widget builtPicture(String img, String name) {
  return Container(
    height: 270,
    width: 250,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(img),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        name,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    ),
  );
}

Widget _buildSearch() {
  return TextField(
    decoration: InputDecoration(
      hintText: "Search by skills...",
      hintStyle: TextStyle(
        color: Colors.black54,
        fontStyle: FontStyle.italic,
      ),
      suffixIcon: Icon(
        Icons.search,
        color: Colors.black54,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: Colors.black38),
        gapPadding: 1,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          "assets/images/bg.png",
          height: 150,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(
                "Why you need on developers and what you will get from hired contractor.",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text(
                "About Position",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  )),
              onPressed: () {},
            ),
          ],
        ),
      )
    ],
  );
}
