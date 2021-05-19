import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanas/UserStatus/checkConnection.dart';
import 'package:wanas/helper/helper.dart';
import 'package:wanas/my/animation.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
import 'package:path/path.dart' as p;
import 'package:wanas/my/profile.dart' as myid;
import 'package:progress_dialog/progress_dialog.dart';

class EditPictures extends StatefulWidget {
  final int number;
  EditPictures(this.number);
  @override
  _EditPicturesState createState() => _EditPicturesState();
}

class _EditPicturesState extends State<EditPictures> {
  var _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  Text('Remove\n  photo'),
                ],
              ),
              onTap: () async {
                var connection = checkConnection();
                connection = await connection;
                if (connection == true) {
                  removePic();
                  Navigator.of(context).pushAndRemoveUntil(
                    SlidePosition(page: myid.Profile(), x: -1.0),
                    (route) => false,
                  );
                } else {
                  connectionDialog(context);
                }
              }),
          GestureDetector(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_size_select_actual_rounded,
                      color: Colors.blue),
                  Text('Gallery'),
                ],
              ),
              onTap: () {
                pickImageGallary();
              }),
          GestureDetector(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt, color: Colors.purple),
                  Text('Camera'),
                ],
              ),
              onTap: () {
                pickImageCamera();
              }),
        ],
      ),
    );
  }

  /* pickImageCompressed(var type) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile compressedImage = await imagePicker.getImage(
      source: type,
      imageQuality: 85,
    );
    setState(() {
      _image = compressedImage;
    });
  }*/

  void pickImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    if (_image != null)
      Navigator.of(context).pushReplacement(SlidePosition(
          page: UploadProfilePicture(image: _image, number: widget.number),
          x: 1.0));
  }

  void pickImageGallary() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    if (_image != null)
      Navigator.of(context).pushReplacement(SlidePosition(
          page: UploadProfilePicture(image: _image, number: widget.number),
          x: 1.0));
  }

  removePic() {
    if (widget.number == 1) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(myid.loggedInUser.uid)
          .update({
        'profilePicture': '',
      });
      UploadProfilePicture().updateMyProfilePictureToOthers('');
    } else if (widget.number == 2) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(myid.loggedInUser.uid)
          .update({
        'coverPicture': '',
      });
    }
  }
}

class UploadProfilePicture extends StatefulWidget {
  final File image;
  final int number;
  UploadProfilePicture({this.image, this.number});
  @override
  _UploadProfilePictureState createState() => _UploadProfilePictureState();

  Future<void> updateMyProfilePictureToOthers(String url) async {
    var chatsIDs = await Helper.getMyChatsIDs(myid.loggedInUser.uid);
    for (int i = 0; i < chatsIDs.length; ++i) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(chatsIDs[i])
          .collection('chats')
          .where('id', isEqualTo: myid.loggedInUser.uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({
            'image': url,
          });
        }
      });
    }
  }
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  ProgressDialog pr;
  String _url;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );

    pr.style(
      borderRadius: MediaQuery.of(context).size.width * 0.05,
      backgroundColor: Colors.white,
      elevation: 5.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.w600),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.width * 1.0,
                width: MediaQuery.of(context).size.width * 1.0,
                child: Image.file(widget.image),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      color: Colors.black,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .045,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          SlidePosition(page: myid.Profile(), x: -1.0),
                          (route) => false,
                        );
                      },
                    ),
                    FlatButton(
                      color: Colors.black,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .045,
                        ),
                      ),
                      onPressed: () async {
                        var connection = checkConnection();
                        connection = await connection;
                        if (connection == true) {
                          pr.show();
                          uploadImage(context);
                        } else {
                          connectionDialog(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage(context) async {
    try {
      String fileName = p.basename(widget.image.path);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profile/${myid.loggedInUser.uid}/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(widget.image);
      uploadTask.whenComplete(() async {
        CircularProgressIndicator();
        String url = await firebaseStorageRef.getDownloadURL();
        print(url);
        setState(() {
          _url = url;
        });
        updatePicture(_url);
        if (widget.number == 1) {
          UploadProfilePicture().updateMyProfilePictureToOthers(_url);
        }
        Navigator.of(context).pushAndRemoveUntil(
          SlidePosition(page: myid.Profile(), x: -1.0),
          (route) => false,
        );
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }

  Future<void> updatePicture(String url) async {
    if (widget.number == 1) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(myid.loggedInUser.uid)
          .update({
        'profilePicture': url,
      });
    } else if (widget.number == 2) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(myid.loggedInUser.uid)
          .update({
        'coverPicture': url,
      });
    }
  }
}
