import 'package:flutter/material.dart';
import 'package:wanas/my/menu.dart';

class Testo extends StatefulWidget {
  @override
  _TestoState createState() => _TestoState();
}

class _TestoState extends State<Testo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Menu(),
      appBar: AppBar(),
    );
  }
}