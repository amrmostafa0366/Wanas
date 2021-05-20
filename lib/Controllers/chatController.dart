import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/UserStatus/checkConnection.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/mychats.dart';
import 'package:flutter/cupertino.dart';

//////////////////////////////////////////////////////////////////////////////////
///SEND MSG

void sendMessage(String id1, String email1, String id2, String msg) async {
  //for me

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(id1)
      .collection('chats')
      .doc(id2)
      .collection('messages')
      .doc('${DateTime.now()}') //
      .set({
    'message': msg,
    'sender': email1,
    'date': DateTime.now(),
  });
  //for him
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(id2)
      .collection('chats')
      .doc(id1)
      .collection('messages')
      .doc('${DateTime.now()}') //
      .set({
    'message': msg,
    'sender': email1,
    'date': DateTime.now(),
  });
}

//////////////////////////////////////////////////////////////////////////////////
///UPDATE LAST

void updateLast(String hisid, String myid) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('chats')
      .doc(myid)
      .update({
    'last': '${DateTime.now().millisecondsSinceEpoch}',
  });

  FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('chats')
      .doc(hisid)
      .update({
    'last': '${DateTime.now().millisecondsSinceEpoch}',
  });
}

//////////////////////////////////////////////////////////////////////////////////
///UPDATE STATUSE

void updateStatus(String hisid, String myid, String status) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('chats')
      .doc(myid)
      .update({
    'status': status,
  });
}

//////////////////////////////////////////////////////////////////////////////////
////UPDATE NEW MESSAGE
void updateNewMessage(String hisid, String myid) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('chats')
      .doc(myid)
      .update({
    'newMessage': true,
  });
}

//////////////////////////////////////////////////////////////////////////////////
///CLEAR CHAT

void clearChat(String myid, String hisid) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('chats')
      .doc(hisid)
      .collection('messages')
      .get()
      .then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
}

//////////////////////////////////////////////////////////////////////////////////
///BLOCK

Future<void> block(
    String myid, String hisid, String hisname, String hisimage) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('UsersIBlocked')
      .doc(hisid)
      .set({
    'id': hisid,
    'name': hisname,
    'image': hisimage,
    'date': DateTime.now(),
  });

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('UsersBlockedMe')
      .doc(myid)
      .set({
    'id': myid,
    'date': DateTime.now(),
  });

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('chats')
      .doc(hisid)
      .delete();

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('chats')
      .doc(myid)
      .delete();
}

void deleteChat(String myid, String hisid) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('chats')
      .doc(hisid)
      .collection('messages')
      .get()
      .then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });

  FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('chats')
      .doc(hisid)
      .delete();
}

///////////////////////////////////////////////////////////////////////////
///REPORT
Future<void> report(String myid, String hisid, String _currentReport) async {
  int reportsCounter = 0;

  FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .collection('UsersReportedMe')
      .doc(myid)
      .set({
    'reason': _currentReport,
    'id': myid,
    'date': DateTime.now(),
  });

  FirebaseFirestore.instance
      .collection('Users')
      .doc(myid)
      .collection('UsersIReported')
      .doc(hisid)
      .set({
    'reason': _currentReport,
    'id': hisid,
    'date': DateTime.now(),
  });

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(hisid)
      .get()
      .then((DocumentSnapshot ds) {
    reportsCounter = ds.data()['reportsCounter'];
  });
  FirebaseFirestore.instance.collection('Users').doc(hisid).update({
    'reportsCounter': reportsCounter + 1,
  });
}

//////////////////////////////////////////////////////////////////////////////
///CHECK EXIST
Future<bool> checkExist(String myid, String hisid) async {
  bool exists = false;
  try {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('UsersIReported')
        .doc(hisid)
        .get()
        .then((doc) {
      if (doc.exists)
        exists = true;
      else
        exists = false;
    });
    return exists;
  } catch (e) {
    return false;
  }
}

////////////////////////////////////////////////////////////////////////
///Report Dialog

reportDialog(BuildContext context, checkreported, String currentUserId,
    String peerUserId) {
  final List<String> reports = [
    'Report reason',
    'Nudity',
    'Violence',
    'Harassment',
    "False information",
    'Spam',
    'Hate speech',
    'Terrorism',
    'Scam',
    'Bullying',
    'Promoting drug use'
  ];
  bool reportedBefore = false;
  String _currentReport = 'Report reason';
  final _formkey = GlobalKey<FormState>();
  // set up the buttons
  Widget cancel = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yes = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.045,
        ),
      ),
      onPressed: () async {
        var connection = checkConnection();
        connection = await connection;
        if (connection == true) {
          if (_formkey.currentState.validate()) {
            if (await checkreported == true) {
              // setState(() {
              reportedBefore = true;
              //  });
            } else if (await checkreported == false) {
              report(currentUserId, peerUserId, _currentReport);

              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      content: Text("reported successfully!",
                          style: TextStyle(color: Colors.green)),
                    );
                  }).whenComplete(() {
                Navigator.of(context)
                    .pushReplacement(SlidePosition(page: MyChats(), x: -1.0));
              });
            }
          } else if (connection == false) {
            connectionDialog(context);
          }
        }
      });

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Report",
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.06,
      ),
    ),
    content: Form(
      key: _formkey,
      child: DropdownButtonFormField(
          value: _currentReport,
          items: reports.map((report) {
            return DropdownMenuItem(
              value: report,
              child: Text(
                report,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
            );
          }).toList(),
          onChanged: (val) =>
              _currentReport = val, //setState(() => _currentReport = val),
          validator: (val) {
            if (val == 'Report reason') {
              return 'Verify the reason of reporting';
            } else if (reportedBefore == true) {
              return 'You have been reported this user before';
            }
            return null;
          }),
    ),
    actions: [
      cancel,
      yes,
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

//////////////////////////////////////////////////////////////////////////////
//Clear Chat Dialog

clearChatDialog(BuildContext context, String currentUserId, String peerUserId) {
  // set up the buttons
  Widget no = FlatButton(
    child: Text(
      "No",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yes = FlatButton(
    child: Text(
      "Yes",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      clearChat(currentUserId, peerUserId);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Clear?",
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
    ),
    content: Text(
      "Are you sure you want to clear this chat?",
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    actions: [
      no,
      yes,
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

///////////////////////////////////////////////////////////////////////////
///Delete Chat Dialog
///
deleteChatDialog(
    BuildContext context, String currentUserId, String peerUserId) {
  // set up the buttons
  Widget no = FlatButton(
    child: Text(
      "No",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yes = FlatButton(
    child: Text(
      "Yes",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      deleteChat(currentUserId, peerUserId);
      /* Navigator.of(context)
            .pushReplacement(SlidePosition(page: MyChats(), x: -1.0));*/
      Navigator.of(context).pushAndRemoveUntil(
          (SlidePosition(page: MyChats(), x: -1.0)), (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Delete?",
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
    ),
    content: Text(
      "Are you sure you want to delete this chat?",
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    actions: [
      no,
      yes,
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

///////////////////////////////////////////////////////////////////////////
///Blockk Dialog
blockDialog(BuildContext context, String currentUserId, String peerUserId,
    String hisname, String hisimage) {
  // set up the buttons
  Widget no = FlatButton(
    child: Text(
      "No",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yes = FlatButton(
    child: Text(
      "Yes",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () async {
      var connection = checkConnection();
      connection = await connection;
      if (connection == true) {
        block(currentUserId, peerUserId, hisname, hisimage);
        /* Navigator.of(context)
            .pushReplacement(SlidePosition(page: MyChats(), x: -1.0));*/
        Navigator.of(context).pushAndRemoveUntil(
            (SlidePosition(page: MyChats(), x: -1.0)), (route) => false);
      } else {
        connectionDialog(context);
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Block?",
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
    ),
    content: Text(
      "Are you sure you want to block this user?",
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    actions: [
      no,
      yes,
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
