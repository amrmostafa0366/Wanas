
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/front/messageBubble.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:wanas/front/profile.dart' as myid;
class MessagesStream extends StatelessWidget {
  final String peerUserId;
  final String currentUserId;
  MessagesStream(this.currentUserId, this.peerUserId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserId)
          .collection('chats')
          .doc(peerUserId)
          .collection('messages')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return
           Center(child: CircularProgressIndicator()); //revision
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['message'];
          final messageSender = message['sender'];

          final currentUser = myid.loggedInUser.email;

          final messageBubble = MessageBubble(
              text: messageText,
              isMe: currentUser == messageSender,
              );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
