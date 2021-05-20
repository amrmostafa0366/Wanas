import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Controllers/UnWantedController.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/menu.dart';
import 'package:wanas/front/mychat.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/front/profile.dart' as myid;

class MyChats extends StatefulWidget {
  @override
  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  Query users = FirebaseFirestore.instance
      .collection('Users')
      .doc(myid.loggedInUser.uid)
      .collection('chats')
      .orderBy('last', descending: true);

  void navigateToChat(
      String hisid, String hisname, String hisimage, bool unWanted) {
    Navigator.of(context).push(SlidePosition(
        page: MyChat(myid.loggedInUser.uid, myid.loggedInUser.email, hisid,
            hisname, hisimage, unWanted),
        x: 1.0));
  }

  void markAsRead(String myid, String hisid) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('chats')
        .doc(hisid)
        .update({
      'newMessage': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
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
                    radius: MediaQuery.of(context).size.width * 0.07,
                    backgroundColor: Colors.transparent,
                    backgroundImage: snapshot.data.docs[index]['image'] == ''
                        ? AssetImage('assets/defProfile.jpg')
                        : CachedNetworkImageProvider(
                            snapshot.data.docs[index]['image']),
                  ),
                  title: Text(
                    snapshot.data.docs[index]['name'],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.055,
                      fontFamily: 'YuseiMagic',
                    ),
                  ),
                  subtitle: Text(
                    snapshot.data.docs[index]['status'],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.0388,
                    ),
                  ),
                  onTap: () async {
                    var unWanted = checkUnwanted(
                        myid.loggedInUser.uid, snapshot.data.docs[index]['id']);
                    navigateToChat(
                        snapshot.data.docs[index]['id'],
                        snapshot.data.docs[index]['name'],
                        snapshot.data.docs[index]['image'],
                        await unWanted);
                    markAsRead(
                        myid.loggedInUser.uid, snapshot.data.docs[index]['id']);
                  },
                  trailing: snapshot.data.docs[index]['newMessage']
                      ? Text(
                          'new message',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.0388,
                          ),
                        )
                      : null,
                );
              });
        },
      ),
    );
  }
}
