import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/UserStatus/checkConnection.dart';
import 'package:wanas/my/profile.dart' as myid;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentAge;
  String _currentAbout;
  String _url;

  Future<void> updateProfile(
      String name, String about, String age, String url) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'name': name,
      'about': about,
      'age': age,
      'profilePicture': url,
    });
  }

  List<String> chatsIDs = [];
  Future getMyChats() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .collection('chats')
        .get();

    for (int i = 0; i < qn.docs.length; ++i) {
      chatsIDs.add(qn.docs[i]['id']);
    }
  }

  Future<void> updateMyNameToOthers(String name) async {
    for (int i = 0; i < chatsIDs.length; ++i) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(chatsIDs[i])
          .collection('chats')
          .where('id', isEqualTo: myid.loggedInUser.uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({
            'name': name,
          });
        }
      });
    }
  }

  @override
  void initState() {
    getMyChats();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(myid.loggedInUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return //Text("Loading");
                  Text('');
            }
            var userDocument = snapshot.data;
            return ListView(children: [
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .03,
                    horizontal: MediaQuery.of(context).size.height * .001,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Edit profile',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.056,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045),
                        ),
                        initialValue: userDocument['name'],
                        validator: (val) =>
                            val.isEmpty ? 'Please enter your name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Bio",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045),
                        ),
                        initialValue: userDocument['about'],
                        validator: (val) => val.isEmpty
                            ? 'Write something about yourself'
                            : null,
                        onChanged: (val) => setState(() => _currentAbout = val),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045),
                        ),
                        initialValue: userDocument['age'],
                        validator: (val) =>
                            val.isEmpty ? 'Please enter your age' : null,
                        onChanged: (val) => setState(() => _currentAge = val),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      FlatButton(
                          height: MediaQuery.of(context).size.height * 0.05,
                          minWidth: MediaQuery.of(context).size.height * 0.01,
                          color: Colors.black,
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * .045,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (_currentName == null) {
                                _currentName = userDocument['name'];
                              }
                              if (_currentAbout == null) {
                                _currentAbout = userDocument['about'];
                              }
                              if (_currentAge == null) {
                                _currentAge = userDocument['age'];
                              }
                              if (_url == null) {
                                _url = userDocument['profilePicture'];
                              }
                              var connection = checkConnection();
                              connection = await connection;
                              if (connection == true) {
                                updateProfile(_currentName, _currentAbout,
                                    _currentAge, _url);

                                updateMyNameToOthers(_currentName);
                                Navigator.pop(context);
                              }
                              else{
                                connectionDialog(context);
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
