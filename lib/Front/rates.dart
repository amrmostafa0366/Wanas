import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Models/RateCard.dart';
import 'package:wanas/front/menu.dart';
import 'package:wanas/front/rate.dart';

class Rates extends StatefulWidget {
  @override
  _RatesState createState() => _RatesState();
}

class _RatesState extends State<Rates> {
  Query rates = FirebaseFirestore.instance
      .collection('Users')
      .orderBy('lastRate', descending: true);

  _showRatePanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Rate(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Ratings'),
      ),
      drawer: Menu(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.edit_rounded),
          onPressed: () {
            _showRatePanel();
          }),
      body: StreamBuilder<QuerySnapshot>(
        stream: rates.snapshots(),
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
                return RateCard(
                snapshot.data.docs[index]['profilePicture'],
                snapshot.data.docs[index]['name'],
                snapshot.data.docs[index]['opinion'],
                snapshot.data.docs[index]['stars'],
                );
              });
        },
      ),
    );
  }
}
