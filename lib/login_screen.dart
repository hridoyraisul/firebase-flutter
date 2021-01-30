import 'package:flutter/material.dart';
import 'registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email,password;
  loginUser(email,password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    if(user != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
  googleSignin() async {
    GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    AuthResult result = await FirebaseAuth.instance.signInWithCredential(credential);
    FirebaseUser user = result.user;
    if(user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Flutter'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                child: Text('Registered yet? Login now..'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ))),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ))),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                }),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Login'),
              textColor: Colors.white,
              onPressed: () {
                loginUser(email,password);
              },
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Login with Google Account'),
              textColor: Colors.white,
              onPressed: () {
                googleSignin();
              },
            ),
          ),
          Center(
            child: Container(
              child: Text('Not registered? Register now'),
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Registration'),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegFun()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
