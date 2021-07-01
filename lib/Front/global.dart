import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Front/post.dart';
import 'package:wanas/Models/postcard.dart';
import 'package:wanas/front/menu.dart';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {

  Query posts = FirebaseFirestore.instance
      .collection('Users')
      .orderBy('postDate', descending: true);

  _showRatePanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Post(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Global'),
      ),
      drawer: Menu(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.edit_rounded),
          onPressed: () {
            _showRatePanel();
          }),
      body: StreamBuilder<QuerySnapshot>(
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Text('');
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (_, index) {
                return PostCard(
                snapshot.data.docs[index]['profilePicture'],
                snapshot.data.docs[index]['name'],
                snapshot.data.docs[index]['post'],
                snapshot.data.docs[index]['postDate'],
                //snapshot.data.docs[index]['stars'],
                );
              });
        },
      ),
    );
  }
}
