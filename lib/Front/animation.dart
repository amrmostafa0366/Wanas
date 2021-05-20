import 'package:flutter/material.dart';

class SlidePosition extends PageRouteBuilder{


  final page;
  final double x;
  SlidePosition({this.page,this.x})
  :super(
    pageBuilder :(context , animation ,animationtwo)=>page,
    transitionsBuilder:  (context,animation , animationtwo,child){
      var begin = Offset(x,0.0);
      var end = Offset.zero;
      var tween = Tween(begin:begin , end:end);
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child:child,);

    }
  );
  }
  /*
class SlideLeft extends PageRouteBuilder {

    var page;
  SlideLeft({this.page})
  :super(
    pageBuilder :(context , animation ,animationtwo)=>page,
    transitionsBuilder:  (context,animation , animationtwo,child){
      var begin = Offset(-1.0,0.0);
      var end = Offset.zero;
      var tween = Tween(begin:begin , end:end);
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child:child,);

    }
  );
}
*/