import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockListController extends StatefulWidget {
  @override
  _BlockListControllerState createState() => _BlockListControllerState();

  static void mychatrooms(String myid,String hisid,List<String> _data/*,String hisemail,String hisname,String histype,String hisimage*/) {
    print('mychatrooms');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('chats')
        .doc(hisid)
        .set({
      'id': hisid,
      'email':_data[0],//hisemail,
      'name': _data[1],//hisname,
      'status': _data[2],//histype,
      'image': _data[3],//hisimage,
      'newMessage':false,
      'last': '${DateTime.now().millisecondsSinceEpoch}',
    });
  }

  static void hischatrooms(String hisid,String myid,List<String> _data/*,String myemail,String myname,String mytype,String myimage*/) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(hisid)
        .collection('chats')
        .doc(myid)
        .set({
      'id': myid,
      'email':_data[0],//myemail,
      'name': _data[1],//myname,
      'status': _data[2],//mytype,
      'image': _data[3],//myimage,
      'newMessage':false,
      'last': '${DateTime.now().millisecondsSinceEpoch}',
    });
  }

   static getUserData(String id) async{
     List<String> _data =['lol','lol','lol','lol'];
     await FirebaseFirestore.instance
                .collection('Users')
                .doc(id)
                .get()
                .then((DocumentSnapshot userSnapshot) {
              
              _data[0]=userSnapshot['email'];
              _data[1]=userSnapshot['name'];
              _data[2]=userSnapshot['status'];
              _data[3]=userSnapshot['photoUrl'];
        });

        /*print(_data[0]+
              _data[1]+
              _data[2]+
              _data[3]);*/
        return _data;
  }

  static Future<void> deleteUserFromUsersIBlocked(String myid,String hisid) async {
    await FirebaseFirestore.instance
            .collection('Users')
            .doc(myid)
            .collection('UsersIBlocked')
            .doc(hisid)
            .delete();
  }

  static Future<void> deleteUserFromUsersBlockedMe(String hisid,String myid) async {
    await FirebaseFirestore.instance
            .collection('Users')
            .doc(hisid)
            .collection('UsersBlockedMe')
            .doc(myid)
            .delete();
  }
  }


class _BlockListControllerState extends State<BlockListController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}