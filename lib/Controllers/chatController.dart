import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatController extends StatefulWidget {
  @override
  _ChatControllerState createState() => _ChatControllerState();

//////////////////////////////////////////////////////////////////////////////////
  ///SEND MSG

  static void sendMessage(String id1, String email1, String id2, String msg) async{
    //for me

   await FirebaseFirestore.instance
        .collection('Users')
        .doc(id1)
        .collection('chats')
        .doc(id2)
        .collection('messages')
        .doc('${DateTime.now()}')//
        .set({
      'message': msg,
      'sender': email1,
      'date':DateTime.now(),
    });
    //for him
   await FirebaseFirestore.instance
        .collection('Users')
        .doc(id2)
        .collection('chats')
        .doc(id1)
        .collection('messages')
        .doc('${DateTime.now()}')//
        .set({
      'message': msg,
      'sender': email1,
      'date':DateTime.now(),
    });
  }

//////////////////////////////////////////////////////////////////////////////////
  ///UPDATE LAST

  static void updateLast(String hisid, String myid) {
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

  static void updateStatus(String hisid, String myid, String status) {
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
static void updateNewMessage(String hisid, String myid) {
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

  static void clearChat(String myid, String hisid) {
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

  static Future<void> block(
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

  static void deleteChat(String myid, String hisid) {
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
  static Future<void> report(
      String myid, String hisid, String _currentReport) async {
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
    if(reportsCounter>=10){
      FirebaseFirestore.instance.collection("BannedIPs").doc('ip').set({
      //  'id':,
        //'ip':,
      });
    }
    FirebaseFirestore.instance.collection('Users').doc(hisid).update({
      'reportsCounter': reportsCounter + 1,
    });
  }
//////////////////////////////////////////////////////////////////////////////
///CHECK EXIST
   static Future<bool> checkExist(String myid, String hisid) async {
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

}

class _ChatControllerState extends State<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
