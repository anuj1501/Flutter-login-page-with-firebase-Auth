import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/setup/signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _confirm_password;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> signUp() async {
    //TODO validate field
    final _formState = _formkey.currentState;

    if (_formState.validate()) {
      //TODO login to firebase
      _formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;

        user.sendEmailVerification();
        //display for the user that we sent an email

        //TODO navigate to home page

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password must be atleast 6 characeters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                validator: (input) {
                  if (input == _password) {
                    return 'Passwords not matching, please try again';
                  }
                },
                onSaved: (input) => _confirm_password = input,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
