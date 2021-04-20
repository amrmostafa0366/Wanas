import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanas/Models/ProfileTile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wanas/my/BlockList.dart';
import 'package:wanas/my/animation.dart';
import 'package:wanas/my/editProfilePic.dart';
import 'package:wanas/my/editprofile.dart';
import 'package:wanas/my/menu.dart';

User loggedInUser;
final _auth = FirebaseAuth.instance;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  void _showEditPanel(Widget screen) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: screen,
          );
        });
  }

  getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

//////////////////////////
  void choiceAction(String choice) {
    if (choice == PopUpMenuConstants.blockList) {
      print('Block List');

      Navigator.of(context).push(SlidePosition(page: BlockList(), x: 1.0));
    }
  }

//////////////////////////
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(
          'Profile',
          style:TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return PopUpMenuConstants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.edit),
          onPressed: () {
            _showEditPanel(EditProfile());
          }),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(loggedInUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return Text('');
                      }
                      double rate;
                      int usersRatedMe = snapshot.data['numUsersRatedMe'];
                      if (usersRatedMe == 0) {
                        rate = 0.0;
                      } else {
                        rate = snapshot.data['userStars'] /
                            snapshot.data['numUsersRatedMe'];
                      }
                      String name = snapshot.data['name'];
                      String email = snapshot.data['email'];
                      String about = snapshot.data['about'];
                      String photo = snapshot.data['photoUrl'];
                      Timestamp time = snapshot.data['timeCreation'];
                      String timeCreation =
                          DateFormat("dd/MM/yyyy").format(time.toDate());
                      String age = snapshot.data['age'];
                      String gender = snapshot.data['gender'];

                      return Column(
                        children: <Widget>[
                          photo.length == 0
                              ? GestureDetector(
                                  child: Hero(
                                    transitionOnUserGestures: true,
                                    tag: 'defHero',
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/defProfile.jpg'),
                                          ),
                                        ),
                                      ),
                                      radius: MediaQuery.of(context).size.width * 0.28,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return DefHero();
                                    }));
                                  })
                              : GestureDetector(
                                  child: Hero(
                                    transitionOnUserGestures: true,
                                    tag: 'profileHero',
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                                photo),
                                          ),
                                        ),
                                      ),
                                      radius: MediaQuery.of(context).size.width * 0.28,
                                    ),
                                  ),
                                  //      radius: 100,
                                  //       ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ProfHero(photo);
                                    }));
                                  }),
                          ProfileTile('Name', name, Icons.person),
                          ProfileTile('Email', email, Icons.email),
                          ProfileTile(
                              'About', about, FlutterIcons.pencil_alt_faw5s),
                          ProfileTile(
                            'Rate',
                            "${rate.toStringAsFixed(1)}/5 ($usersRatedMe)",
                            Icons.star_half,
                          ),
                          ProfileTile(
                              'Age', age, FlutterIcons.birthday_cake_faw),
                          ProfileTile(
                              'Gender', gender, FlutterIcons.gender_male_mco),
                          ProfileTile(
                              'Creation date', timeCreation, Icons.access_time)
                        ],
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopUpMenuConstants {
  static const String blockList = 'Block List';
  static const List<String> choices = <String>[
    blockList,
  ];
}

class DefHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile photo',
          style:TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.04),
            child: GestureDetector(
                child: Icon(Icons.edit),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.04),
                          child: EditProfilePicture(),
                        );
                      });
                }),
          ),
        ],
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'defHero',
            child: Image.asset('assets/defProfile.jpg'),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ProfHero extends StatelessWidget {
  final String prof;
  ProfHero(this.prof);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile photo',
          style:TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.04),
            child: GestureDetector(
                child: Icon(Icons.edit,color: Colors.white),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.04),
                          child: EditProfilePicture(),
                        );
                      });
                })
          ),
        ],
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'profileHero',
            child: CachedNetworkImage(imageUrl: prof),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
