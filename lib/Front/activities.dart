import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wanas/front/activity.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/profile.dart' as myid;
//import 'package:wanas/my/myprofile.dart';
import 'menu.dart';


class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  Future _data;

  Future getActivities() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('activities').get();
    return qn.docs;
  }

  Future<void> updateActivity(String activity) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'activity': activity,
    });

    final locData = await Location().getLocation();
    updateLocation(locData.latitude, locData.longitude);

    Navigator.of(context).push(SlidePosition(
        page: Activity(activity, locData.latitude, locData.longitude),x: 1.0));
  }

  Future<void> updateLocation(lat, long) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'location': {
        'latitude': lat,
        'longitude': long,
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _data = getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Activities',
        style:TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.056,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _data = getActivities();
          });
          return _data;
        },
        child: Container(
          child: FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width * 0.14,
                              minHeight: MediaQuery.of(context).size.width * 0.15,
                              maxWidth: MediaQuery.of(context).size.width * 0.14,
                              maxHeight: MediaQuery.of(context).size.width * 0.15,
                            ),
                            child: CachedNetworkImage(
                                imageUrl: snapshot.data[index]['image']),
                          ),
                          title: Text(snapshot.data[index]['name'],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.078,
                                fontFamily: 'Bangers',
                              )),
                          onTap: () =>
                              updateActivity(snapshot.data[index]['name']),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
