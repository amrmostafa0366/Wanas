import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final  subtitle;
  final IconData icon;

  ProfileTile(this.title,this.subtitle ,this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
            title: Text(title,style: TextStyle(fontSize: MediaQuery.of(context).size.width *.05),),
            subtitle: Text(subtitle.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width *.04),),
            leading: Icon(icon,size: MediaQuery.of(context).size.width *.07),
    );
  }

}
