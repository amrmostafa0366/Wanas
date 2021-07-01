import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/profile.dart' as myid;
//import 'package:wanas/my/myprofile.dart' as myid;
import 'dart:math'; 
//import 'package:wanas/my/userProfile.dart';

class Activity extends StatefulWidget {
  final String activity;
  final lat, long;
  Activity(this.activity, this.lat, this.long);
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {


  navigateToUser(String id, String hisname, double latitude, double longitude) {
    Navigator.of(context)
        .push(SlidePosition(page: //UserProfile(id, hisname, latitude, longitude),x:1.0));
                                  myid.Profile(number:1,hisid:id, hisname:hisname, latitude:latitude, longitude:longitude),x:1.0));
  }

  String distance(double lat2, double lon2, String unit) {
    double theta = widget.long - lon2;
    double dist = sin(deg2rad(widget.lat)) * sin(deg2rad(lat2)) +
        cos(deg2rad(widget.lat)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    if (unit == 'K') {
      dist = dist * 1.609344;
    } else if (unit == 'M') {
      dist = dist * 1.609344 * 1000;
    } else if (unit == 'N') {
      dist = dist * 0.8684;
    }
    return dist.toStringAsFixed(2);
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

  var users;
  activity(String activity) {
    setState(() {
      users = FirebaseFirestore.instance
          .collection('Users')
          .where('activity', isEqualTo:activity)
         // .where('country', isEqualTo: widget.activity)
          .where('id', isNotEqualTo: myid.loggedInUser.uid);
          
    });
  }

  choose() {
    if (widget.activity == 'celebrate') {
      activity('celebrate');
    } else if (widget.activity == 'charity') {
      activity('charity');
    } else if (widget.activity == 'cinema') {
      activity('cinema');
    } else if (widget.activity == 'cooking') {
      activity('cooking');
    } else if (widget.activity == 'cycling') {
      activity('cycling');
    } else if (widget.activity == 'fishing') {
      activity('fishing');
    } else if (widget.activity == 'gym') {
      activity('gym');
    } else if (widget.activity == 'horse riding') {
      activity('horse riding');
    } else if (widget.activity == 'hospital') {
      activity('hospital');
    } else if (widget.activity == 'picnic') {
      activity('picnic');
    } else if (widget.activity == 'running') {
      activity('running');
    } else if (widget.activity == 'shopping') {
      activity('shopping');
    } else if (widget.activity == 'swimming') {
      activity('swimming');
    } else if (widget.activity == 'tennis') {
      activity('tennis');
    }
  }

  @override
  void initState() {
    choose();
    super.initState();
  }

  @override
  void dispose() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'activity': 'none',
      'location': {
        'latitude': 0.0,
        'longitude': 0.0,
      }
    });
    super.dispose();
  }
  
double dist=0.0;

  filterDialog() {
  // set up the buttons
  Widget cancle = FlatButton(
    child: Text(
      "Cancle",
      style: TextStyle(color: Colors.black
      ,
      fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget apply = FlatButton(
    child: Text(
      "Apply",
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
      
    ),
    onPressed: () {
        
      }
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Filter",
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
    ),
 /*   content: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "distance in meter, ex:500",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .045),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your name' : null,
                      onChanged: (val) {
                        setState(() => dist = double.parse(val));
                      },
                    ),*/
    actions: [
      cancle,
      apply,
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
          backgroundColor: Colors.black,
          title: Text(widget.activity,
          style:TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
          ),
          actions:[
            IconButton(
              onPressed:(){
                filterDialog();
            },
             icon: Icon(Icons.filter_alt_sharp))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  return ListTile(
                      leading: CircleAvatar(
                        radius:MediaQuery.of(context).size.width * 0.07,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              snapshot.data.docs[index]['profilePicture'] == ''
                                  ? AssetImage('assets/defProfile.jpg')
                                  : NetworkImage(
                                      snapshot.data.docs[index]['profilePicture'])),
                      title: Text(
                        snapshot.data.docs[index]['name'],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.055,
                          fontFamily: 'YuseiMagic',
                        ),
                      ),
                      subtitle: Container(
                        child: Row(
                          children: [
                            if (snapshot.data.docs[index]['location']
                                        ['latitude'] !=
                                    0 &&
                                snapshot.data.docs[index]['location']
                                        ['longitude'] !=
                                    0)
                              Text(distance(
                                          snapshot.data.docs[index]['location']
                                              ['latitude'],
                                          snapshot.data.docs[index]['location']
                                              ['longitude'],
                                          'M')
                                      .toString() +
                                  ' m',
                                  style:TextStyle(
                                    fontSize:MediaQuery.of(context).size.width * 0.0388,
                                  ),
                                  ),
                          ],
                        ),
                      ),
                      onTap: () {
                        navigateToUser(
                            snapshot.data.docs[index]['id'],
                            snapshot.data.docs[index]['name'],
                            snapshot.data.docs[index]['location']['latitude'],
                            snapshot.data.docs[index]['location']['longitude']);
                      });
                });
          },
        ));
  }
}
