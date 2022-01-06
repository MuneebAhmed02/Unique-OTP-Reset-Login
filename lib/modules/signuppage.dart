import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unique/modules/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool changeButton = false;
  @override
  Widget build(BuildContext context) {
    // final bool _hidden = true;
    final TextEditingController firstname = TextEditingController();
    final TextEditingController lastname = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController cpassword = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    void registerhere() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          changeButton = true;
        });
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseFirestore db = FirebaseFirestore.instance;
        final String Fname = firstname.text;
        final String Lname = lastname.text;
        final String Email = email.text;
        final String Password = password.text;
        // ignore: unused_local_variable
        final String CPassword = cpassword.text;
        await Future.delayed(Duration(seconds: 1));
        try {
          final UserCredential user = await auth.createUserWithEmailAndPassword(
              email: Email, password: Password);
          await db
              .collection('user')
              .doc(user.user!.uid)
              .set({"firstname": Fname, "lastname": Lname});
          Navigator.of(context).pushNamed("/verify");
        } catch (e) {
          print('error');
        }
        setState(() {
          changeButton = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset('assets/images/signup.png', fit: BoxFit.fill),
                      Text(
                        'Sign up to Unique',
                        style: const TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First name is empty";
                            }
                            return null;
                          },
                          controller: firstname,
                          decoration: const InputDecoration(
                              label: Text('First name'),
                              hintText: 'Enter your first name here'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last name is empty";
                            }
                            return null;
                          },
                          controller: lastname,
                          decoration: const InputDecoration(
                            label: Text('Last name'),
                            hintText: 'Enter your last name here',
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
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
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is empty";
                            } else if (value.length < 8) {
                              return 'Password length at least 8 characters';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                            label: Text('Password'),
                            hintText: 'Enter your password here',
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Confirm Password is empty";
                            } else if (value.length < 8) {
                              return 'Confirm Password length at least 8 characters';
                            }
                            return null;
                          },
                          controller: cpassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text('Confirm Password'),
                            hintText: 'Repeat your password',
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      // ignore: deprecated_member_use
                      InkWell(
                        onTap: registerhere,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: changeButton ? 50 : 100,
                          height: 45,
                          alignment: Alignment.center,
                          child: changeButton
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(
                                  changeButton ? 50 : 10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account!',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Loginpage()));
                              },
                              child: Text('Login here',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
