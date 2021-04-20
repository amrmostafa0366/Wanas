import 'package:cloud_firestore/cloud_firestore.dart';

class Helper {
  static void updateStatus(String uid, String status) {
    FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'status': status,
    });
  }

  static List<String> chatsIDs = [];
  static getMyChats(String uid) async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('chats')
        .get();

    for (int i = 0; i < qn.docs.length; ++i) {
      chatsIDs.add(qn.docs[i]['id']);
    }
  }

  static void updateMyStatusToOthers(String uid, String status) {
    for (int i = 0; i < chatsIDs.length; ++i) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(chatsIDs[i])
          .collection('chats')
          .where('id', isEqualTo: uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({'status': status});
        }
      });
    }
  }

  static getMyChatsIDs(String uid) async {
    List<String> _data =[];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('chats')
        .get();

    for (int i = 0; i < qn.docs.length; ++i) {
      _data.add(qn.docs[i]['id']);
    }
    return _data;
  }
}

/*const GOOGLE_API_KEY ="AIzaSyB_gl0t0ykwWyBoCUDG9HTep-xEQSCeC-o";

class LocationHelper{
  static String generateLocationPreviewImage({double latitude, double longitude}){

    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';

}
}

//APP ID = NchmGvwqJWo94UPs27yJ
//ACCESS KEY ID	= EnZfYzqdO-mkuiqm7rbFhw
//ACCESS KEY SECRET= yFEMV8o4FZn0ThyyRrZFt0KgbDsj0RrTMplPeqx7ExYsTbUIFzrt_9zQH7QykAj9jbSgPNi9U2NSfgdEhTcAvQ*/
