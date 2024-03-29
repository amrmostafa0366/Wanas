import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/my/profile.dart' as myid;
class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  final _formkey = GlobalKey<FormState>();

  double rating = 0.0;
  String opinion;

  rateApp(stars, opinion) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      'stars': stars,
      'opinion': opinion,
      'lastRate': '${DateTime.now().millisecondsSinceEpoch}'
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(myid.loggedInUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return //Text("Loading");
                  Text('');
            }
            var userDocument = snapshot.data;
            return ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 12.0),
                    Container(
                      alignment: Alignment.center,
                      child: SmoothStarRating(
                        borderColor: Colors.black,
                        color: Colors.black,
                        rating: rating,
                        isReadOnly: false,
                        size: 50,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          rating = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 40.0),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Write your opinion about the app"),
                          validator: (val) => val.isEmpty
                              ? 'Write your opinion about the app'
                              : null,
                          onChanged: (value) {
                            setState(() => opinion = value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    ButtonTheme(
                      minWidth: 100.0,
                      child: RaisedButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              rateApp(rating, opinion);
                              Navigator.pop(context);
                            }
                          }),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
