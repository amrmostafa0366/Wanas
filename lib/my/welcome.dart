import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanas/my/login.dart';
import 'package:wanas/my/register.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
              child: Container(
                  child: Image.asset(
            'assets/Welcome.jpg',
            fit: BoxFit.cover,
          ))),
          Column(
            children: <Widget>[
              Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 10.0,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.height * .4,
                  height: MediaQuery.of(context).size.height * .075,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .21),
                child: Material(
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
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .05),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
