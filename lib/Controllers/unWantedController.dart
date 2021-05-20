import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


     Future<bool> checkUnwanted(String myid, String hisid) async {
    bool unWanted = false;
    String reason = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('UsersIReported')
        .doc(hisid)
        .get()
        .then((doc) {
      if (doc.exists) unWanted = true;
      reason = 'UsersIReported';
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('UsersReportedMe')
        .doc(hisid)
        .get()
        .then((doc) {
      if (doc.exists) unWanted = true;
      reason = 'UsersReportedMe';
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('UsersIBlocked')
        .doc(hisid)
        .get()
        .then((doc) {
      if (doc.exists) unWanted = true;
      reason = 'UsersIBlocked';
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(myid)
        .collection('UsersBlockedMe')
        .doc(hisid)
        .get()
        .then((doc) {
      if (doc.exists) unWanted = true;
      reason = 'UsersBlockedMe';
    });
    return unWanted;
  
  }