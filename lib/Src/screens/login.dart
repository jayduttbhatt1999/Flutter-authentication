import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:payplaza/Src/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payplaza/Src/screens/reset.dart';
import 'package:payplaza/Src/screens/verify.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      backgroundColor: Colors.blueGrey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                color: Theme.of(context).accentColor,
                child: Text("SignIn"),
                onPressed: () => _signIn(_email, _password),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              MaterialButton(
                color: Theme.of(context).accentColor,
                child: Text("SignUp"),
                onPressed: () => _signUp(_email, _password),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("Forgot Password?",
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _signIn(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password).then((_) {
        //success
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      // Toast.show(msg: e.message, gravity: Toast.CENTER);
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    }
  }
  _signUp(String _email, String _password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_) {
        //success
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyScreen()));
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    }
  }
}
