import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String image;
  final String name;
  final String opinion;
  final String date;
  //final double stars;

  PostCard(this.image, this.name, this.opinion/*, this.stars*/,this.date);
//^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.07,
              backgroundColor: Colors.transparent,
              backgroundImage: image == ''
                  ? AssetImage('assets/defProfile.jpg')
                  : CachedNetworkImageProvider(image),
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: 'YuseiMagic',
              ),
            ),
          /*  subtitle: StarRating(
                rating: stars,
                color: Colors.black,
              ),*/
              subtitle: Text(date.substring(0,16) ,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontFamily: 'YuseiMagic',
              ),
              ),
            ),

         /* Padding(
            padding: EdgeInsets.all(5),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: image == ''
                    ? AssetImage('assets/defProfile.jpg')
                    : CachedNetworkImageProvider(image),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'YuseiMagic',
                  ),
                ),
              ),
            ],
          ), */
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Container(
            alignment: opinion.contains(RegExp('[a-zA-Z]'))? Alignment.topLeft:Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                opinion,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                //  fontFamily: 'Handlee',
                 // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

         SizedBox(height: MediaQuery.of(context).size.height * .02,),
       /*   Center(
            child: Container(
              alignment: Alignment.center,
              child: StarRating(
                rating: stars,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          // Text(snapshot.data.docs[index]['stars'].toString()), */
        ],
      ),
    );
  }
}

// i need to make it responsive here..
