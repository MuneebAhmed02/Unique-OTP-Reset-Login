import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

// import 'package:email_auth_example/auth_config.dart';
class Emailotp extends StatefulWidget {
  @override
  _EmailotpState createState() => _EmailotpState();
}

class _EmailotpState extends State<Emailotp> {
  bool changeButton = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  bool submitValid = false;
  late EmailAuth emailAuth;
  @override
  void initState() {
    super.initState();
    emailAuth = EmailAuth(
      sessionName: 'Started',
    );
  }

  @override
  Widget build(BuildContext context) {
    void sendOTP() async {
      bool res = await emailAuth.sendOtp(
          recipientMail: emailController.value.text, otpLength: 5);
      if (res) {
        print('An OTP has been sent to your email');
        setState(() {
          submitValid = true;
        });
      } else {
        print('Eroor');
      }
      // EmailAuth emailAuth = EmailAuth(sessionName: 'Start Session');
      // var res = await emailAuth.sendOtp(
      //     recipientMail: emailController.value.text, otpLength: 5);
      // if (res) {
      //   print('An OTP has been sent to your email');
      // } else {
      //   print('Error');
      // }
    }

    verifyOTP() {
      print(emailAuth.validateOtp(
          recipientMail: emailController.value.text,
          userOtp: otpcontroller.value.text));
      Navigator.of(context).pushNamed(
        "/home",
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        title: Text(
          'Check your email',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      suffixIcon: TextButton(
                        child: Text('Send OTP'),
                        onPressed: sendOTP,
                      ),
                      label: Text('Email'),
                      hintText: 'Enter your Email'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: otpcontroller,
              decoration:
                  InputDecoration(label: Text('OTP'), hintText: 'Enter OTP'),
            ),
          ),
          InkWell(
            onTap: verifyOTP,
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
                      'Verify',
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
