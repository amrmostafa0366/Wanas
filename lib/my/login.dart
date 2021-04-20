import 'package:wanas/UserStatus/LoginStatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanas/helper/helper.dart';
import 'package:wanas/my/myprofile.dart';
import 'package:wanas/my/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .075,
                horizontal: MediaQuery.of(context).size.height * .075),
            child: Form(
              key: _formkey,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .031),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter the correct password' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * .016)),
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 10.0,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.height * .4,
                        height: MediaQuery.of(context).size.height * .075,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * .05),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            try {
                              final newUser =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email.trim(), password: password);

                              if (newUser != null) {
                                Helper.updateStatus(newUser.user.uid, 'online');

                                Helper.getMyChats(newUser.user.uid)
                                    .whenComplete(() {
                                  Helper.updateMyStatusToOthers(
                                      newUser.user.uid, 'online');
                                });

                                LoginStatus().writeStaus(true);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyProfile()));
                              }
                            } catch (e) {
                              setState(() {
                                if (e.toString().contains('user-not-found')) {
                                  error = 'user not fonud';
                                } else if (e
                                    .toString()
                                    .contains('Unable to resolve host')) {
                                  error = 'check your internet connection';
                                } else if (e
                                    .toString()
                                    .contains('invalid-email')) {
                                  error = 'invalid email';
                                } else if (e
                                    .toString()
                                    .contains('wrong-password')) {
                                  error = 'wrong password';
                                } else if (e.toString().contains('GMT')) {
                                  error = 'check your device date and time';
                                }

                                //  error=e.toString();
                              });
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.width * .040),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Register()));
                      },
                      child: Text(
                        'not registered yet',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.width * .040),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
