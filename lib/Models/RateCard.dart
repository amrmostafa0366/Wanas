import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Models/StarRating.dart';

class RateCard extends StatelessWidget {
  final String image;
  final String name;
  final String opinion;
  final double stars;

  RateCard(this.image, this.name, this.opinion, this.stars);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: image == ''
                  ? AssetImage('assets/defProfile.jpg')
                  : CachedNetworkImageProvider(image),
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'YuseiMagic',
              ),
            ),
            subtitle: StarRating(
                rating: stars,
                color: Colors.black,
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
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                opinion,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Handlee',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

         SizedBox(height: 12.0),
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
