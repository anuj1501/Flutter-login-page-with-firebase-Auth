import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/setup/signin.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googlesignin = GoogleSignIn();

  void Signout(BuildContext context) async {
    await _auth.signOut().then((val) => print("sign out"));

    await googlesignin.signOut().then((value) => print("sign out from google"));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  File _image;

  Future getImage(bool isCamera) async {
    File image;

    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Home ${widget.user.email}'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {
                  getImage(true);
                }),
            _image == null
                ? Container()
                : Image.file(_image, height: 300, width: 300),
          ],
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () => Signout(context),
        shape: StadiumBorder(),
        child: Text(
          "Sign out",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.green,
      ),
    );
  }
}
