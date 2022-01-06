import 'package:flutter/material.dart';
import 'package:unique/modules/add.dart';
// import 'package:flutter_modular/flutter_modular.dart';
import 'package:unique/modules/editprofile.dart';
import 'package:unique/modules/emailotp.dart';
import 'package:unique/modules/homepage.dart';
import 'package:unique/modules/loginpage.dart';
import 'package:unique/modules/signuppage.dart';
import 'package:unique/modules/verifyemail.dart';
import 'package:unique/widgets/myslider.dart';
// import 'modules/shared/app_module.dart';
// import 'modules/shared/presentation/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

import 'modules/forgotpassword.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            routes: {
              '/': (context) => Myslider(),
              '/login': (context) => Loginpage(),
              '/signup': (context) => Signuppage(),
              '/home': (context) => Homepage(),
              '/profile': (context) => Profileedit(),
              '/forgot': (context) => Forgotpassword(),
              '/verify': (context) => Verify(),
              '/otp': (context) => Emailotp(),
              '/add': (context) => Add()
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
