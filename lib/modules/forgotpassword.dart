import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool changeButton = false;
    sendRequest() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          changeButton = true;
        });
        await Future.delayed(Duration(seconds: 1));
        FirebaseAuth auth = FirebaseAuth.instance;
        String Email = email.text;
        auth.sendPasswordResetEmail(email: Email);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        title: Text('Reset Password'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is empty";
                  }
                  return null;
                },
                controller: email,
                decoration: const InputDecoration(
                    label: Text('Email'), hintText: 'Enter your email here'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: sendRequest,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: changeButton ? 50 : 140,
              height: 45,
              alignment: Alignment.center,
              child: changeButton
                  ? Icon(
                      CupertinoIcons.arrow_2_circlepath,
                      color: Colors.white,
                    )
                  : Text(
                      'Send Request',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(changeButton ? 50 : 10)),
            ),
          ),
        ],
      ),
    );
  }
}
