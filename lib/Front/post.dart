import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/front/profile.dart' as myid;
class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formkey = GlobalKey<FormState>();

  //double rating = 0.0;
  String opinion;

  post(opinion) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(myid.loggedInUser.uid)
        .update({
      //'stars': stars,
      'post': opinion,
      'postDate': '${DateTime.now()}'
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.125),
                    /*
                    Container(
                      alignment: Alignment.center,
                      child: SmoothStarRating(
                        borderColor: Colors.black,
                        color: Colors.black,
                        rating: rating,
                        isReadOnly: false,
                        size: 50,
                        filledIconData: Icons.star_outlined,
                        halfFilledIconData: Icons.star_half_outlined,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          rating = value;
                        },
                      ),
                    ),*/
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 40.0),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "What's on your mind?"),
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
                            'Post',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              post(opinion);
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
