
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.isMe, this.img});

  final String text;
  final String img;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            //  elevation: 5.0,
            color: isMe ? Colors.blue : Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: text.isEmpty
                  ? CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                            height: 500.0,
                            decoration: BoxDecoration(
                              borderRadius: isMe
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))
                                  : BorderRadius.only(
                                      bottomLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                      placeholder: (context, url) => Container(
                            /*    child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFFff6768))), */
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, size: 150),
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                      imageUrl: img.toString())
                  : Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.white,
                        fontSize: MediaQuery.of(context).size.width * .05,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
