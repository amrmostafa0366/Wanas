import 'package:wanas/UserStatus/LoginStatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanas/my/login.dart';
//import 'package:wanas/my/myprofile.dart';
import 'package:wanas/my/profile.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, about, password, confirmPassword;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  final _formkey = GlobalKey<FormState>();
  final List<String> genders = ['Gender', 'Male', 'Female'];
  String _currentGender = 'Gender';
  final List<String> ages = [
    'Age',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60',
    '61',
    '62',
    '63',
    '64',
    '65',
    '66',
    '67',
    '68',
    '69',
    '70',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
    '77',
    '78',
    '79',
    '80',
    '81',
    '82',
    '83',
    '84',
    '85',
    '86',
    '87',
    '88',
    '89',
    '90',
    '91',
    '92',
    '93',
    '94',
    '95',
    '96',
    '97',
    '98',
    '99',
    '100'
  ];
  String _currentAge = "Age";
  String error = '';

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .03,
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
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    DropdownButtonFormField(
                      value: _currentGender,
                      items: genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(
                            gender,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentGender = val),
                      validator: (val) =>
                          val == 'Gender' ? 'Verify your gender' : null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    DropdownButtonFormField(
                      value: _currentAge,
                      items: ages.map((age) {
                        return DropdownMenuItem(
                          value: age,
                          child: Text(
                            age,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentAge = val),
                      validator: (val) =>
                          val == 'Age' ? 'Verify your age' : null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "about",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Write somehing about yourself' : null,
                      onChanged: (val) {
                        setState(() => about = val);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator:
                          // ignore: missing_return
                          (val) //=> val.isEmpty ? 'Enter your Email' : null,
                          {
                        if (val.isEmpty) {
                          return 'Enter your email';
                        } else if (!val.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val){
                        if(val.isEmpty){
                          return '';
                        }
                        else if(val.length<6){
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) => confirmPassword != password
                          ? 'You entered two different passwords'
                          : null,
                      onChanged: (val) {
                        setState(() => confirmPassword = val);
                      },
                    ),
                   Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .016)),
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 10.0,
                      child: Builder(builder: (BuildContext context) {
                        return MaterialButton(
                          minWidth: MediaQuery.of(context).size.height * .4,
                          height: MediaQuery.of(context).size.height * .075,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * .05),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email.trim(),
                                        password: password);
                                if (newUser != null) {
                                  getCurrentUser();

                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(newUser.user.uid)
                                      .set({
                                    'id': newUser.user.uid,
                                    'name': name,
                                    'email': email,
                                    'about': about,
                                    'gender': _currentGender,
                                    'age': _currentAge,
                                    'profilePicture': "",
                                    'coverPicture':"",
                                    'timeCreation': DateTime.now(),
                                    'reportsCounter': 0,
                                    'blockList': [],
                                    'reportList': [],
                                    'status': "online",
                                    'activity': "none",
                                    'location': {
                                      'latitude': 0.0,
                                      'longitude': 0.0,
                                    },
                                    'userStars': 0.0,
                                    'numUsersRatedMe': 0,
                                  }).whenComplete(() {
                                    //  print('Document Added');
                                  });

                                  LoginStatus().writeStaus(true);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));
                                }
                              } catch (e) {
                          setState(() {
                            if (e.toString().contains('email-already-in-use')) {
                              error = 'this email is already taken';
                            } else if (e
                                .toString()
                                .contains('Unable to resolve host')) {
                              error = 'check your internet connection';
                            } else if (e.toString().contains('weak-password')) {
                              error = 'Password should be at least 6 characters';
                            } else if (e.toString().contains('GMT')) {
                              error = 'check your device date and time';
                            }
                             // error=e.toString();
                             // print(error);
                          });
                        }
                            }
                          },
                        );
                      }),
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
                            builder: (BuildContext context) => Login()));
                      },
                      child: Text(
                        'already have account',
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
