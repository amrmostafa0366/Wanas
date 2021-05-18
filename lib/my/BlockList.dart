import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Controllers/blockListController.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/my/profile.dart' as myid;

class BlockList extends StatefulWidget {
  @override
  _BlockListState createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  Query users = FirebaseFirestore.instance
      .collection('Users')
      .doc(myid.loggedInUser.uid)
      .collection('UsersIBlocked')
      .orderBy('date', descending: true);

  unBlockDialog(
    BuildContext context,
    String hisid,
  ) {
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
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        var _mydata =
            await BlockListController.getUserData(myid.loggedInUser.uid);
        var _hisdata = await BlockListController.getUserData(hisid);
        // print(_hisdata);
        // print(_mydata);
        BlockListController.deleteUserFromUsersIBlocked(
            myid.loggedInUser.uid, hisid);
        BlockListController.deleteUserFromUsersBlockedMe(
            hisid, myid.loggedInUser.uid);
        BlockListController.mychatrooms(myid.loggedInUser.uid, hisid, _hisdata);
        BlockListController.hischatrooms(hisid, myid.loggedInUser.uid, _mydata);
        Navigator.pop(context);

        // Navigator.of(context).pushReplacement(SlideLeft(page: MyChats()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Unblock?"),
      content: Text("Are you sure you want to Unblock this user?"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Block List'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.06,
                    backgroundColor: Colors.transparent,
                    backgroundImage: snapshot.data.docs[index]['image'] == ''
                        ? AssetImage('assets/defProfile.jpg')
                        : CachedNetworkImageProvider(
                            snapshot.data.docs[index]['image']),
                  ),
                  title: Text(
                    snapshot.data.docs[index]['name'],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontFamily: 'YuseiMagic',
                    ),
                  ),
                  trailing: FlatButton(
                    child:
                        Text('Unblock',
                         style: TextStyle(
                          color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        )),
                    color: Colors.red,
                    onPressed: () {
                      unBlockDialog(context, snapshot.data.docs[index]['id']);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
