import 'package:flutter/material.dart';
import 'package:login_page/setup/signin.dart';
import 'package:login_page/setup/signup.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void navigatetosignin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigatetosignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('My Firebase app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: Colors.green,
              onPressed: navigatetosignup,
              child: Text('Sign Up'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: Colors.green,
              onPressed: navigatetosignin,
              child: Text('Sign In'),
            ),
          ),
        ],
      ),
    );
  }
}
