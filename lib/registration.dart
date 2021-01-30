import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: RegFun(),
  ));
}

class RegFun extends StatefulWidget {

  @override
  _RegFunState createState() => _RegFunState();
}

class _RegFunState extends State<RegFun> {
  String name, email, password;
  int phone;

  getName(name) {
    this.name = name;
  }

  getEmail(email) {
    this.email = email;
  }

  getPhone(phone) {
    this.phone = int.parse(phone);
  }

  getPassword(password) {
    this.password = password;
  }

  createData(name, email, phone, password) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    DocumentReference documentReference =
    Firestore.instance.collection("users").document(name);
    Map<String, dynamic> users = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    };
    documentReference.setData(users).whenComplete(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Flutter'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                child: Text('Create New User'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ))),
                onChanged: (String name) {
                  getName(name);
                }),
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
                onChanged: (String email) {
                  getEmail(email);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Phone No",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ))),
                onChanged: (String phone) {
                  getPhone(phone);
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
                onChanged: (String password) {
                  getPassword(password);
                }),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Register'),
              textColor: Colors.white,
              onPressed: () {
                createData(name, email, phone, password);
              },
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Login'),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
