import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      checkedEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        title: Text('Verify your email'),
      ),
      body: Center(
        child: Text('An email has been sent to ${user.email} please verify'),
      ),
    );
  }

  Future<void> checkedEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushNamed(
        "/home",
      );
    }
  }
}
