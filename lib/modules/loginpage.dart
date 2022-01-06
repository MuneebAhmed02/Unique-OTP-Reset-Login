import 'package:flutter/material.dart';
import 'package:unique/modules/homepage.dart';
import 'package:unique/modules/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe, unused_import
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool changeButton = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loginhere() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      String Email = email.text;
      String Password = password.text;

      await Future.delayed(Duration(seconds: 1));
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: Email, password: Password);
        final DocumentSnapshot snapshot =
            await db.collection('user').doc(user.user!.uid).get();
        // ignore: unused_local_variable
        final data = snapshot.data();

        Navigator.of(context).pushNamed(
          "/otp",
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Wrong Password'),
              );
            });

        setState(() {
          changeButton = false;
        });
      }
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        await CircularProgressIndicator();
        Navigator.of(context).pushNamed(
          "/home",
        );
      }
    }
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   final OAuthCredential facebookAuthCredential =
  //       await FacebookAuthProvider.credential(
  //     loginResult.accessToken!.token,
  //   );

  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Image.asset('assets/images/login.png', fit: BoxFit.fill),
              Text(
                'Sign in to Unique',
                style: const TextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is empty";
                          }
                          return null;
                        },
                        controller: email,
                        decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: 'Enter your email here'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is empty";
                          }
                          return null;
                        },
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Password'),
                          hintText: 'Enter your password here',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextButton(
                      child: Text('Forgot password?',
                          style: TextStyle(fontSize: 17)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: loginhere,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: changeButton ? 50 : 90,
                  height: 45,
                  alignment: Alignment.center,
                  child: changeButton
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signuppage()));
                      },
                      child: Text('Register here',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Or Sign up with',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: AnimatedContainer(
                        height: 50,
                        width: 50,
                        duration: Duration(seconds: 1),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25))),
                    onTap: () {
                      print('login with facebook function');
                    },
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  InkWell(
                    child: AnimatedContainer(
                        height: 50,
                        width: 50,
                        duration: Duration(seconds: 1),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.googlePlusG,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25))),
                    onTap: () {
                      signInWithGoogle(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
