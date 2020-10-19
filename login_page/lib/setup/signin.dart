import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/pages/home.dart';
import 'package:login_page/setup/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  GoogleSignIn _googleauth = GoogleSignIn();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> signIn() async {
    //TODO validate field
    final _formState = _formkey.currentState;

    if (_formState.validate()) {
      //TODO login to firebase
      _formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("You 've registered!"),
                content: Text("You will be directed to home page"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(user: user))),
                      child: Text("ok"))
                ],
              );
            });

        //TODO navigate to home page
        /*
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
          */
      } catch (e) {
        print(e.message);
      }
    }
  }

  void navigatetosignup() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Future<void> googleSignIn() async {
    final GoogleSignInAccount googleuser = await _googleauth.signIn();

    final GoogleSignInAuthentication googleauth =
        await googleuser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleauth.idToken, accessToken: googleauth.accessToken);

    FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('SignIn'),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
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
              SizedBox(
                height: 20.0,
              ),
              FloatingActionButton.extended(
                onPressed: signIn,
                splashColor: Colors.greenAccent,
                label: Text(
                  'Sign In',
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(60, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'New to this app?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: navigatetosignup,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GoogleSignInButton(
                      onPressed: googleSignIn,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
