import 'dart:io';

import 'package:flutter/material.dart';


checkConnection()async{
  bool check = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //  print('connected');
      return check = true;
    }
  } on SocketException catch (_) {
    //print('not connected');
    return check = false;

  }
}

connectionDialog(BuildContext context) {
    showDialog(
      barrierDismissible:false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            content: Text("Check your internet connection",
              style:TextStyle(
                fontSize:MediaQuery.of(context).size.width *0.045,
              ),
            ),
          );
        });
  }