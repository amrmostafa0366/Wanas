import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wanas/UserStatus/LoginStatus.dart';
import 'package:wanas/UserStatus/checkConnection.dart';
import 'package:wanas/helper/helper.dart';
import 'package:wanas/main.dart';
import 'package:wanas/my/activities.dart';
import 'package:wanas/my/animation.dart';
import 'package:wanas/my/help2.dart';
import 'package:wanas/my/mychats.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/my/profile.dart' as myid;
import 'package:wanas/my/rates.dart';
import 'package:wanas/my/testo.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  /*
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

  Future<void> updateMyStatusToOthers() async {
    for (int i = 0; i < chatsIDs.length; ++i) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(chatsIDs[i])
          .collection('chats')
          .where('id', isEqualTo: myid.loggedInUser.uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({'type': "offline"});
        }
      });
    }
  }
  
  //////////////////////////////////////

  void updateStatus() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'type': 'offline',
    });
  }
*/

////////////////////////////
/*
  String ip;

  Future getIp() async {
    final ipAddress = await IpInfoApi.getIPAddress();

    setState(() {
      ip = ipAddress;
    });
  }

  //////////////////////////
  checkBannedIp() {
    bool banned;
    FirebaseFirestore.instance
        .collection('BannedIPs')
        .doc(ip)
        .get()
        .then((DocumentSnapshot userSnapshot) {
      if (userSnapshot.exists) {
        banned = true;
      } else {
        banned=false;
      }
    });
    return banned;
  }
*/
///////////////////////////
  var reportsCounter;
  void getReoprtsCounter() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        reportsCounter = ds.data()['reportsCounter'];
      });
    });
  }

  banDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text("Banned!", style: TextStyle(color: Colors.red)),
            content: Text("You have reached the maximum number of reports!"),
          );
        });
  }

  //bool banned;
  @override
  void initState() {
    //getMyChats();
    getReoprtsCounter();
    // getIp();
    //banned = checkBannedIp();
    //print(ip);
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  static var profileTile = 1;
  static var activitiesTile, chatsTile, helpTile, ratingTile = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*0.844,
      child: Drawer(
        child: SingleChildScrollView (
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: const DecorationImage(
                    image: AssetImage('assets/menuLogo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null,
              ),
              ListTile(
                tileColor: profileTile == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.person_oct,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Profile',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  setState(() {
                    profileTile = 1;

                    activitiesTile = chatsTile = helpTile = ratingTile = 0;
                  }),
                  Navigator.of(context).pushReplacement(
                     // SlidePosition(page: myid.MyProfile(), x: 1.0)),
                      SlidePosition(page: myid.Profile(), x: 1.0)),
                },
              ),
              ListTile(
                tileColor:
                    activitiesTile == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.run_fast_mco,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Activities',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        activitiesTile = 1;

                        profileTile = chatsTile = helpTile = ratingTile = 0;
                      }),
                      Navigator.of(context).pushReplacement(
                          SlidePosition(page: Activities(), x: 1.0)),
                    }
                  else
                    {banDialog(context)}
                },
              ),
              ListTile(
                tileColor: chatsTile == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.chat_ent,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Chats',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        chatsTile = 1;

                        profileTile =
                            activitiesTile = helpTile = ratingTile = 0;
                      }),
                      Navigator.of(context).pushReplacement(
                          SlidePosition(page: MyChats(), x: 1.0)),
                    }
                  else
                    {banDialog(context)}
                },
              ),
              ListTile(
                tileColor: ratingTile == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.star_faw5s,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Rating',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        ratingTile = 1;

                        profileTile = chatsTile = helpTile = activitiesTile = 0;
                      }),
                      Navigator.of(context).pushReplacement(
                          SlidePosition(page: Rates(), x: 1.0)),
                    }
                  else
                    {banDialog(context)}
                },
              ),
              ListTile(
                tileColor: helpTile == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.help_box_mco,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Help',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  setState(() {
                    helpTile = 1;

                    activitiesTile = chatsTile = profileTile = ratingTile = 0;
                  }),
                  Navigator.of(context)
                      .pushReplacement(SlidePosition(page: Help2(), x: 1.0)),
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Contact us',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () async {
                  final Email email = Email(
                    body:
                        "", //'Hi WanasApp Developers.I have a problem in this email:\n${myid.loggedInUser.email}\n and the problem is..',

                    subject: 'WanasApp',

                    recipients: ['wanasapp0@gmail.com'],

                    isHTML: false,
                  );

                  await FlutterEmailSender.send(email);
                },
              ),
              ListTile(
                leading: Icon(
                  FlutterIcons.exit_to_app_mco,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Logout',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () async {
                  var connection = checkConnection();
                  connection = await connection;
                  if(connection == true){
                    
                  setState(() {
                    profileTile =
                        activitiesTile = chatsTile = helpTile = ratingTile = 0;
                  });

                  Helper.updateStatus(myid.loggedInUser.uid, 'offline');

                  Helper.getMyChats(myid.loggedInUser.uid).whenComplete(() {
                    Helper.updateMyStatusToOthers(
                        myid.loggedInUser.uid, 'offline');
                  });

                  _auth.signOut();

                  LoginStatus().writeStaus(false);

                  /*Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyApp()));*/

                      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyApp()),(route) => false);

                    /*  Navigator.of(context).pushAndRemoveUntil(
              SlidePosition(page: MyApp(), x: -1.0),(route) => false,);*/
                  }
                },
              ),
              
              ListTile(
                leading: Icon(
                  FlutterIcons.setting_ant,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Test profile'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Testo()));
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
