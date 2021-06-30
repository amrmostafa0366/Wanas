import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanas/Controllers/UnWantedController.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/messagesStream.dart';
import 'package:wanas/front/profile.dart';
//import 'package:wanas/my/viewProfile.dart';
import 'package:wanas/Controllers/chatController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyChat extends StatefulWidget {
  final String currentUserId;
  final String currentUserEmail;
  final String peerUserId;
  final String hisname;
  final String hisimage;
  final bool uWu;

  MyChat(this.currentUserId, this.currentUserEmail, this.peerUserId,
      this.hisname, this.hisimage, this.uWu);

  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> with WidgetsBindingObserver {
  final messageTextController = TextEditingController();
  String messageText = '';

  var checkreported;
  var unWanted;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    setState(() {
      checkreported = checkExist(widget.currentUserId, widget.peerUserId,'Users','UsersIReported');
      unWanted = checkUnwanted(
          widget.currentUserId, widget.peerUserId);
    });
  }

//////////////////////////////////////////////////////

  void choiceAction(String choice) {
    if (choice == PopUpMenuConstants.viewProfile) {
      // print('View Profile');

      Navigator.of(context)
          // .push(SlidePosition(page: ViewProfile(widget.peerUserId, widget.name),x: 1.0));
          .push(SlidePosition(
              page: Profile(
                  number: 2, hisid: widget.peerUserId, hisname: widget.hisname),
              x: 1.0));
    } else if (choice == PopUpMenuConstants.clearChat) {
      // print('Clear chat');
      clearChatDialog(context, widget.currentUserId, widget.peerUserId);
    } else if (choice == PopUpMenuConstants.deleteChat) {
      // print('Delete chat');
      deleteChatDialog(context, widget.currentUserId, widget.peerUserId);
    } else if (choice == PopUpMenuConstants.report) {
      // print('Report');
      // reportDialog(context);
      reportDialog(
          context, checkreported, widget.currentUserId, widget.peerUserId);
    } else if (choice == PopUpMenuConstants.block) {
      // print('block');
      blockDialog(context, widget.currentUserId, widget.peerUserId,
          widget.hisname, widget.hisimage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // updateStatus('online');
    updateStatus(
        widget.peerUserId, widget.currentUserId, 'online');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 70,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_outlined),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: widget.hisimage == ''
                        ? AssetImage('assets/defProfile.jpg')
                        : NetworkImage(widget.hisimage),
                  ),
                ],
              )),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return PopUpMenuConstants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Expanded(
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hisname,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * .06),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.currentUserId)
                              .collection('chats')
                              .doc(widget.peerUserId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              );
                            }
                            if (snapshot.data['status'] == null) {
                              return Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              //need to be optimized..
                              return Text(
                                snapshot.data['status'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              );
                            } else {
                              String status = snapshot.data['status'];

                              return Text(
                                status,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              );
                            }
                          })
                    ]),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(widget.currentUserId, widget.peerUserId),
            textFieldOr(),
          ],
        ),
      ),
    );
  }

  textFieldOr() {
    print(widget.uWu);
    if (widget.uWu == true) {
      return cantChat();
    } else {
      return textfield();
    }
  }

  cantChat() {
    return Container(
        height: MediaQuery.of(context).size.width * .1,
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("You can't chat with this person anymore.",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .04,
                  color: Colors.white,
                )),
            TextButton(
              onPressed: () {
                whyDialog(context);
              },
              child: Text(
                'Why?',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: Colors.blue),
              ),
            ),
          ],
        ));
  }

  whyDialog(BuildContext context) {
    Widget ok = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text("Why can't chat?", style: TextStyle(color: Colors.blue)),
            content: Text(
                "may be this person blocked or reported you, or vice versa."),
            actions: [
              ok,
            ],
          );
        });
  }

  textfield() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: false,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * .05),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02,
                    horizontal: MediaQuery.of(context).size.width * .05),
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
              controller: messageTextController,
              onChanged: (value) {
                messageText = value;
                if (messageText.length == 0) {
                  updateStatus(
                      widget.peerUserId, widget.currentUserId, 'online');
                } else {
                  updateStatus(
                      widget.peerUserId, widget.currentUserId, 'typing...');
                }
              },
            ),
          ),

          //flat button to send typed message in the previous textfield
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: FlatButton(
              onPressed: () {
                messageTextController.clear();

                if (messageText.length != 0) {
                  updateStatus(
                      widget.peerUserId, widget.currentUserId, 'online');
                }
                if (messageText.isEmpty) {
                } else {
                  sendMessage(widget.currentUserId,
                      widget.currentUserEmail, widget.peerUserId, messageText);
                  // Timestamp.now());
                  updateLast(
                      widget.peerUserId, widget.currentUserId);
                updateNewMessage(
                      widget.peerUserId, widget.currentUserId);
                  messageText = '';
                }
              },
              child: Icon(
                Icons.send_rounded,
                size: MediaQuery.of(context).size.width * .09,
              ),
            ),
          ),
        ],
      ),
    );
  }

//not efficient
  getTime() async {
    http.Response response =
        await http.get('http://worldtimeapi.org/api/timezone/Africa/Cairo');
    Map data = jsonDecode(response.body);
    String datetime = data['datetime'];
    return datetime;
  }
}

class PopUpMenuConstants {
  static const String viewProfile = 'View profile';
  static const String clearChat = 'Clear chat';
  static const String deleteChat = 'Delete chat';
  static const String report = 'Report';
  static const String block = 'Block';

  static const List<String> choices = <String>[
    viewProfile,
    clearChat,
    deleteChat,
    report,
    block
  ];
}
