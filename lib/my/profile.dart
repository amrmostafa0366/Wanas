import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wanas/Controllers/blockListController.dart';
import 'package:wanas/Controllers/unWantedController.dart';
import 'package:wanas/Models/ProfileTile.dart';
import 'package:wanas/Models/StarRating.dart';
import 'package:wanas/my/BlockList.dart';
import 'package:wanas/my/animation.dart';
import 'package:wanas/my/editPictures.dart';
import 'package:wanas/my/menu.dart';
import 'package:wanas/my/mychat.dart';
import 'package:wanas/my/staticMap.dart';
import 'editprofile.dart';

User loggedInUser;
final _auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  //new
  final int number;

//user's profile,,from "Activity"
  final String hisid;
  final String hisname;
  final double latitude;
  final double longitude;

  Profile(
      {this.number, this.hisid, this.hisname, this.latitude, this.longitude});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //my profile
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

  //my profile
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

  //my profile
  void choiceAction(String choice) {
    if (choice == PopUpMenuConstants.blockList) {
      print('Block List');

      Navigator.of(context).push(SlidePosition(page: BlockList(), x: 1.0));
    }
  }

//user's profile "viewProfile" from "Chat"
  getOldRate() async {
    var oldRate;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.uid)
        .collection('UsersIRated')
        .doc(widget.hisid)
        .get()
        .then((DocumentSnapshot userSnapshot) {
      if (userSnapshot.exists) {
        oldRate = userSnapshot['stars'];
      } else {
        oldRate = 0.0;
      }
    });
    return oldRate;
  }

//user's profile "viewProfile" from "Chat"
  getStars() async {
    var stars;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.hisid)
        .get()
        .then((DocumentSnapshot userSnapshot) {
      stars = userSnapshot['userStars'];
    });
    return stars;
  }

//user's profile "viewProfile" from "Chat"
  getNumberOfUsersRated() async {
    var numberOfUsers;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.hisid)
        .get()
        .then((DocumentSnapshot userSnapshot) {
      numberOfUsers = userSnapshot['numUsersRatedMe'];
    });
    return numberOfUsers;
  }

//user's profile "viewProfile" from "Chat"
  updateAvgRate(double stars, int numberOfUsers) {
    FirebaseFirestore.instance.collection('Users').doc(widget.hisid).update({
      'numUsersRatedMe': numberOfUsers,
      'userStars': stars,
    });
  }

//user's profile "viewProfile" from "Chat"
  updateUsersIRated() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.uid)
        .collection('UsersIRated')
        .doc(widget.hisid)
        .set({
      'id': widget.hisid,
      'stars': newRate,
    });
  }

//user's profile "viewProfile" from "Chat"
  double newRate = 0.0;
  var oldRate;
  var stars;
  var numUsersRatedMe;

//user's profile "viewProfile" from "Chat"
  rateDialog(BuildContext context) {
    // set up the buttons
    Widget cancel = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget rate = FlatButton(
      child: Text(
        "Rate",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        oldRate = getOldRate();
        oldRate = await oldRate;
        print(oldRate);
        getOldRate();
        //if its not hte first time to rate this user ,,
        if (oldRate != 0.0) {
          stars = getStars();
          stars = await stars;
          stars = stars - oldRate;
          stars = stars + newRate;

          numUsersRatedMe = getNumberOfUsersRated();
          numUsersRatedMe = await numUsersRatedMe;

          updateUsersIRated();
          updateAvgRate(stars, numUsersRatedMe);
        } else {
          //if its the first time to rate this user,,
          stars = getStars();
          stars = await stars;
          stars = stars + newRate;

          numUsersRatedMe = getNumberOfUsersRated();
          numUsersRatedMe = await numUsersRatedMe + 1;
          updateUsersIRated();
          updateAvgRate(stars, numUsersRatedMe);
        }
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
          vertical: MediaQuery.of(context).size.height * .18),
      title: Text("Rate"),
      content: Container(
        alignment: Alignment.center,
        child: SmoothStarRating(
          borderColor: Colors.black,
          color: Colors.black,
          rating: newRate,
          isReadOnly: false,
          size: MediaQuery.of(context).size.width * .1,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 5,
          allowHalfRating: true,
          spacing: 2.0,
          onRated: (value) {
            newRate = value;
          },
        ),
      ),
      actions: [
        cancel,
        rate,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//user's profile "viewProfile" from "Activity"
  unWantedDialog(BuildContext context, int x) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            content: x == 1
                ? Text("You can't know this person's location")
                : Text("You can't chat with this person"),
          );
        });
  }

//user's profile "viewProfile" from "Activity"
  navigateToMap() {
    Navigator.of(context).push(SlidePosition(
        page: StaticMap(widget.latitude, widget.longitude), x: -1.0));
  }

  var _mydata;
  var _hisdata;
  getUsersData() async {
    _mydata = await BlockListController.getUserData(loggedInUser.uid);
    _hisdata = await BlockListController.getUserData(widget.hisid);
  }

//user's profile "viewProfile" from "Activity"
  myChatRooms() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(loggedInUser.uid)
        .collection('chats')
        .doc(widget.hisid)
        .set({
      'id': widget.hisid,
      'email': _hisdata[0],
      'name': _hisdata[1],
      'status': _hisdata[2],
      'image': _hisdata[3],
      'newMessage': false,
      'last': '${DateTime.now().millisecondsSinceEpoch}',
    });
  }

//user's profile "viewProfile" from "Activity"
  hisChatRooms() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.hisid)
        .collection('chats')
        .doc(loggedInUser.uid)
        .set({
      'id': loggedInUser.uid,
      'email': _mydata[0],
      'name': _mydata[1],
      'status': _mydata[2],
      'image': _mydata[3],
      'newMessage': false,
      'last': '${DateTime.now().millisecondsSinceEpoch}',
    });
  }

  navigateToChat() {
    Navigator.of(context).push(SlidePosition(
        page: MyChat(loggedInUser.uid, loggedInUser.email, widget.hisid,
            widget.hisname, _hisdata[3], false),
        x: 1.0));
  }

  Widget action() {
    if (widget.number == null) {
      return PopupMenuButton<String>(
        onSelected: choiceAction,
        itemBuilder: (BuildContext context) {
          return PopUpMenuConstants.choices.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      );
    } else if (widget.number == 1) {
      return Text('');
    } else if (widget.number == 2) {
      return TextButton(
        child: Text(
          'Rate',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          rateDialog(context);
        },
      );
    }
    return Text('');
  }

  Widget floatingAction() {
    if (widget.number == null) {
      return FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.edit),
          onPressed: () {
            _showEditPanel(EditProfile());
          });
    } else if (widget.number == 1) {
      return Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.085,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(Icons.location_on, color: Colors.white),
                heroTag: 'Map',
                onPressed: () async {
                  if (await checkUnWanted == false) {
                    navigateToMap();
                  } else {
                    unWantedDialog(context, 1);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.085,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(Icons.message),
                heroTag: 'Chat',
                onPressed: () async {
                  if (await checkUnWanted == false) {
                    myChatRooms();
                    hisChatRooms();
                    navigateToChat();
                  } else {
                    unWantedDialog(context, 2);
                  }
                },
              ),
            ),
          ),
        ],
      );
    } else if (widget.number == 2) {
      return null;
    }
    return null;
  }

  var checkUnWanted;

  @override
  void initState() {
    super.initState();
    getCurrentUser();

    if (widget.number == 1) {
      checkUnWanted =
          UnWantedController.checkUnwanted(loggedInUser.uid, widget.hisid);
      getUsersData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.hisid == null ? Menu() : null,
      appBar: AppBar(
        title: widget.hisname == null
            ? Text(
                'Profile',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.056,
                ),
              )
            : Text(
                widget.hisname,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.056,
                ),
              ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          action(),
        ],
      ),
      floatingActionButton: floatingAction(),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              StreamBuilder(
                  stream: widget.hisid == null
                      ? FirebaseFirestore.instance
                          .collection('Users')
                          .doc(loggedInUser.uid)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.hisid)
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
                    String profilePicture = snapshot.data['profilePicture'];
                    String coverPicture = snapshot.data['coverPicture'];
                    Timestamp time = snapshot.data['timeCreation'];

                    String timeCreation =
                        DateFormat("dd/MM/yyyy").format(time.toDate());

                    String age = snapshot.data['age'];

                    String gender = snapshot.data['gender'];

                    return Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height * 0.34,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: coverPicture.length == 0
                                    ? Image.asset('assets/Welcome.jpg',
                                        fit: BoxFit.cover)
                                    : CachedNetworkImage(
                                        imageUrl: coverPicture,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.32,
                              child: profilePicture.length == 0
                                  ? CircleAvatar(
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
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                    )
                                  : GestureDetector(
                                      child: Hero(
                                        transitionOnUserGestures: true,
                                        tag: 'profileHero',
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        profilePicture),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            //change Cover Picture
                            widget.hisid == null
                                ? Positioned(
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                    top: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                          _showEditPanel(
                                              EditPictures(2)); //edit cover
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Text(''),
                            // change profile picture
                            widget.hisid == null
                                ? Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.60,
                                    top: MediaQuery.of(context).size.height *
                                        0.38,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                        ),
                                        color: Colors.black,
                                        onPressed: () {
                                          _showEditPanel(
                                              EditPictures(1)); //editProfile
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Text(''),
                          ]),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * .0001),

                        Text(
                          name,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StarRating(
                          rating: rate,
                          color: Colors.yellow,
                        ),
                         ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * .025),

                        Divider(),
                        //  ProfileTile('Name', name, Icons.person),

                        ProfileTile('Email', email, Icons.email),

                        ProfileTile(
                            'Bio', about, FlutterIcons.pencil_alt_faw5s),

                        ProfileTile(
                          'Rate',
                          "${rate.toStringAsFixed(1)}/5 ($usersRatedMe)",
                          Icons.star_half,
                        ),

                        ProfileTile('Age', age, FlutterIcons.birthday_cake_faw),

                        ProfileTile(
                            'Gender', gender, FlutterIcons.gender_male_mco),

                        ProfileTile(
                            'Creation date', timeCreation, Icons.access_time)
                      ],
                    );
                  })
            ],
          ),
        ],
      ),
    );
  }
}

class HeroProfile extends StatelessWidget {
  final String photo;
  final int number;
  HeroProfile({this.photo, this.number});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile photo',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
        backgroundColor: Colors.black,
        actions: number == null
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              child: EditPictures(2), //edit cover
                            );
                          });
                    }),
              ]
            : null,
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'profileHero',
            child: photo == null
                ? Image.asset('assets/defProfile.jpg')
                : CachedNetworkImage(imageUrl: photo),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
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
