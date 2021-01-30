import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: MainApp(),
  ));
}
class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  loginPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  regPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegFun()));
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
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Login'),
              textColor: Colors.white,
              onPressed: () {
                loginPage();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.white60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text('Register'),
              textColor: Colors.white,
              onPressed: () {
                regPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
