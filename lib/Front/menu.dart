import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wanas/Front/testo.dart';
import 'package:wanas/UserStatus/LoginStatus.dart';
import 'package:wanas/UserStatus/checkConnection.dart';
import 'package:wanas/helper/helper.dart';
import 'package:wanas/front/activities.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/help2.dart';
import 'package:wanas/front/mychats.dart';
import 'package:wanas/front/profile.dart' as myid;
import 'package:wanas/front/global.dart';
import 'package:flutter_restart/flutter_restart.dart';
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  /*
E/flutter ( 9032): [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: setState() called after dispose(): _MenuState#f1656(lifecycle state: defunct, not mounted)
E/flutter ( 9032): This error happens if you call setState() on a State object for a widget that no longer appears in the widget tree (e.g., whose parent widget no longer includes the widget in its build). This error can occur when code calls setState() from a timer or an animation callback.
E/flutter ( 9032): The preferred solution is to cancel the timer or stop listening to the animation in the dispose() callback. Another solution is to check the "mounted" property of this object before calling setState() to ensure the object is still in the tree.
E/flutter ( 9032): The preferred solution is to cancel the timer or stop listening to the animation in the dispose() callback. Another solution is to check the "mounted" property of this object before calling setState() to ensure the object is still in the tree.
E/flutter ( 9032): This error might indicate a memory leak if setState() is being called because another object is retaining a reference to this State object after it has been removed from the tree. To avoid memory leaks, consider breaking the reference to this object during dispose().
   */
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
      barrierDismissible:false,
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
    //getReoprtsCounter();
    // getIp();
    //banned = checkBannedIp();
    //print(ip);
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  static var profileTile = 1;
  static var activitiesTile, chatsTile, helpTile, global = 0;

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

                    activitiesTile = chatsTile = helpTile = global = 0;
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
                  getReoprtsCounter(),
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        activitiesTile = 1;

                        profileTile = chatsTile = helpTile = global = 0;
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
                  getReoprtsCounter(),
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        chatsTile = 1;

                        profileTile =
                            activitiesTile = helpTile = global = 0;
                      }),
                      Navigator.of(context).pushReplacement(
                          SlidePosition(page: MyChats(), x: 1.0)),
                    }
                  else
                    {
                      banDialog(context)
                      }
                },
              ),
              ListTile(
                tileColor: global == 1 ? Colors.grey : Colors.transparent,
                leading: Icon(
                  FlutterIcons.globe_americas_faw5s,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Global',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                onTap: () => {
                  getReoprtsCounter(),
                  if (reportsCounter == null || reportsCounter < 10)
                    {
                      setState(() {
                        global = 1;

                        profileTile = chatsTile = helpTile = activitiesTile = 0;
                      }),
                      Navigator.of(context).pushReplacement(
                          SlidePosition(page: Global(), x: 1.0)),
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

                    activitiesTile = chatsTile = profileTile = global = 0;
                  }),
                  Navigator.of(context)
                      .pushReplacement(SlidePosition(page: Help2(), x: 1.0)),
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.email_rounded,
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
                       'Hi WanasApp Developers.I have a problem in this email:\n${myid.loggedInUser.email}\n and the problem is..',

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
                        activitiesTile = chatsTile = helpTile = global = 0;
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

                    /*  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyApp()),(route) => false); */

                    /*  Navigator.of(context).pushAndRemoveUntil(
              SlidePosition(page: MyApp(), x: -1.0),(route) => false,);*/
               await FlutterRestart.restartApp();
                  }
                  else{
                    connectionDialog(context);
                  }
                },
              ),
             /* 
              ListTile(
                leading: Icon(
                  FlutterIcons.exit_to_app_mco,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Testo',
                style:TextStyle(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                ),
                ),
                
                  
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacement(SlidePosition(page: MyApple(), x: 1.0)),
                },
              ),
              */
              /*ListTile(
                leading: Icon(
                  FlutterIcons.setting_ant,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text('Test profile'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LOL()));
                },
              ),*/
              
            ],
          ),
        ),
      ),
    );
  }
}
