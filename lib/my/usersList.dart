import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/my/menu.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
//import 'package:wanas/my/userProfile.dart';
import 'package:wanas/my/profile.dart' as myid;
class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Future _data;

  Future getUsers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot lt = await firestore
        .collection('Users')
        .where(
          'id',
          isLessThan: myid.loggedInUser.uid,
        )
        .get();

    QuerySnapshot gt = await firestore
        .collection('Users')
        .where(
          'id',
          isGreaterThan: myid.loggedInUser.uid,
        )
        .get();

    return lt.docs + gt.docs;
  }

  Future testing() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot test = await firestore.collection('Users').get();
    return test.docs;
  }

  @override
  void initState() {
    super.initState();
    // getUsers();
    _data = getUsers();
  }

  navigateToUser(String id, String hisname) {
   // Navigator.push(context,
    //    MaterialPageRoute(builder: (context) => UserProfile(id,hisname)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _data = getUsers();
          });
          return _data;
        },
        child: Container(
          child: FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      // child: Text('Loading...'),
                      // child: Text(''),
                      child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: snapshot.data[index]
                                          ['photoUrl'] ==
                                      ''
                                  ? AssetImage('assets/defProfile.jpg')
                                  : NetworkImage(snapshot.data[index][
                                      'photoUrl'])), // no matter how big it is, it won't overflow
                          title: Text(
                            snapshot.data[index]['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'YuseiMagic',
                            ),
                          ),

                          onTap: () => navigateToUser(
                              snapshot.data[index]['id'],
                              snapshot.data[index]['name']),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
