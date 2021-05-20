import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:wanas/front/menu.dart';
//import 'package:wanas/my/myprofile.dart' as myid;
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Help',
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  title: Text('Overall'),
                  subtitle: Row(
                    children: [
                      Text('How to use,'),
                      Text('Find people,'),
                      Text('Share intrests,'),
                      Text('...'),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              title: Text('Profile'),
              subtitle: Row(
                children: [
                  Text('Privacy,'),
                  Text('Profile picture,'),
                  Text('Name,'),
                  Text('Bio,'),
                  Text('Age,...'),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Activities'),
              subtitle: Row(
                children: [
                  Text('Activity selection,'),
                  Text('Share interests,'),
                  Text('Location,'),
                  Text('...'),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Chats'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Rating'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Reports'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Block'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Contact us'),
              onTap: () async {
                final Email email = Email(
                  body: "",//'Hi WanasApp Developers.I have a problem in this email:\n${myid.loggedInUser.email}\n and the problem is..',
                  subject: 'WanasApp',
                  recipients: ['wanasapp0@gmail.com'],
                  isHTML: false,
                );

                await FlutterEmailSender.send(email);
              },
            ),
          ],
        ));
  }
}
