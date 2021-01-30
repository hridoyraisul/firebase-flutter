import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name, email, password;
  int phone;
  FirebaseUser user;
  // HomeScreen({this.user});

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
    DocumentReference documentReference =
    Firestore.instance.collection("users").document(name);
    Map<String, dynamic> users = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    };
    documentReference.setData(users).whenComplete(() {
      print('Name: ${name} ' + 'Email: ${email} ' + 'Phone: 0${phone}');
    });
  }

  readData() {
    DocumentReference documentReference =
    Firestore.instance.collection("users").document(name);
    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["name"]);
      print(datasnapshot.data["email"]);
      print(datasnapshot.data["phone"]);
    });
  }

  Future getUser() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    return qn.documents;
  }

  updateData() {
    DocumentReference documentReference =
    Firestore.instance.collection("users").document(name);
    Map<String, dynamic> users = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    };
    documentReference.setData(users).whenComplete(() {
      print('Name: ${name} ' + 'Email: ${email} ' + 'Phone: 0${phone}');
    });
  }

  deleteData() {
    DocumentReference documentReference = Firestore.instance.collection("users").document(name);
    documentReference.delete().whenComplete(() {
      print("$name deleted");
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
            child: Row(
              children: [
                Container(
                  child: Text('Update User Data'),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.logout),
                    iconSize: 40.0,
                    onPressed: (){
                      FirebaseAuth.instance.signOut().whenComplete((){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      });
                    },
                  ),
                )
              ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text('Create'),
                textColor: Colors.white,
                onPressed: () {
                  createData(name, email, phone, password);
                },
              ),
              RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text('Read'),
                textColor: Colors.white,
                onPressed: () {
                  readData();
                },
              ),
              RaisedButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text('Update'),
                textColor: Colors.white,
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text('Delete'),
                textColor: Colors.white,
                onPressed: () {
                  deleteData();
                },
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Email")),
                Expanded(child: Text("Phone No")),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: StreamBuilder(
                stream: Firestore.instance.collection("users").snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                          return Row(
                            children: [
                              Expanded(
                                  child: Text(documentSnapshot["name"])
                              ),
                              Expanded(
                                  child: Text(documentSnapshot["email"])
                              ),
                              Expanded(
                                  child: Text("0"+documentSnapshot["phone"].toString())
                              ),
                            ],
                          );
                        });
                  }
                }
            ),
          ),
          // FutureBuilder(
          //   future: getUser(),
          //     builder: (_,snapshot){
          //     return ListView.builder(
          //         itemCount: snapshot.data.length,
          //         itemBuilder: (_,index){
          //           DocumentSnapshot data = snapshot.data[index];
          //           return ListTile(
          //             tileColor: Colors.greenAccent,
          //             title: Text(data["name"]),
          //             subtitle: Text(data["email"]),
          //           );
          //         }
          //     );
          //     }
          // )
        ],
      ),
    );
  }
}
