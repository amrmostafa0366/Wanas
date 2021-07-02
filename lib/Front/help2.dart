import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:wanas/front/animation.dart';
import 'package:wanas/front/menu.dart';

final List<String> howToUse = [
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FWhatsApp%20Image%202021-07-02%20at%2019.36.36.jpeg?alt=media&token=84a835dd-5363-4354-afbe-05b4250a6282',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F2.jpg?alt=media&token=513ab7a8-ca79-4bde-9a47-f96552e8d5a9',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F3.jpg?alt=media&token=6547cece-fce7-4365-a23f-d9fdd1360880',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F4.jpg?alt=media&token=c6454be5-83e9-45f5-be5a-fa6f9c57795c',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F5.jpg?alt=media&token=37195b26-9755-45cd-82fa-bab1fe35d84a',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F6.jpg?alt=media&token=1daeb996-1dc7-47af-9645-1ab5a546773c',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F7.jpg?alt=media&token=27ee72af-8573-4d6f-a135-235cbc0f24d6',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F8.jpg?alt=media&token=f617c91e-75e7-4ed2-9df9-5325e1fddc71',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F9%20-%20Copy.jpg?alt=media&token=2b83338f-479c-42ee-992d-0bfb4f3492d7',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F10map%20-%20Copy.jpg?alt=media&token=ebad2bdb-77b4-4a4f-ba05-58764bac1bae',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2F10chat%20-%20Copy.jpg?alt=media&token=e0c4b2a4-a348-4f8b-8e27-309196a2090f',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2Fchat.jpg?alt=media&token=7f0775c3-2fac-4d65-986c-230b43781fa8',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Foverview%2Fhowtouse%2Factivities.jpg?alt=media&token=71e7cb65-e44b-4e3a-a1db-9662cf4018db',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2F4.jpg?alt=media&token=64e1a760-720e-4a40-a30e-96beb19978f3',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2F1.jpg?alt=media&token=a4d3c19d-5a9d-418c-9884-64299a7157ac',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2F5.jpg?alt=media&token=3d5f1756-88fc-4479-8bb0-c5bbed0fb986',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2F3.jpg?alt=media&token=9b68781e-93f4-4fbe-b3ba-c9145d05c826',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F1.jpg?alt=media&token=afa5cfc9-32d5-4ffd-97b1-3aa620b9ec1b',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F4.jpg?alt=media&token=29b77e02-9cf7-449e-a42f-a28460aaa7f2',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F6.jpg?alt=media&token=4a5d6460-ab32-4c60-976d-d78eea3c0608',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F3.jpg?alt=media&token=6a7ce995-8374-491f-8453-52046d0a9fc0',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F7.jpg?alt=media&token=0ee85684-b8cc-4c2d-918f-b851da5e71d5',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F6%20-%20Copy.jpg?alt=media&token=7210417b-8e75-449b-8ebf-40a5a134d384',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F2.jpg?alt=media&token=ab2a8f4c-b0fa-4f9d-85ce-d6e557d5df5e',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fchats%2FclearAndDelete%2F5.jpg?alt=media&token=35985059-7bfb-4446-b07b-89bd5907318b',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F1.jpg?alt=media&token=20167e76-a344-4f96-91b4-105c681093b4',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F4.jpg?alt=media&token=245e1d5c-d473-43ca-9115-bda56b6c438f',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F3.jpg?alt=media&token=ae747941-7280-43cf-b05d-fda6f619072b',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F10.jpg?alt=media&token=075471c4-e2b1-463a-977e-d5f924c5be0e',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F7.jpg?alt=media&token=71cefef7-a7c5-4bcc-af1b-8aa1be19c88c',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F5.jpg?alt=media&token=c78daf0d-d6c2-43f0-89bf-2fe86e0251ff',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F11.jpg?alt=media&token=beeebea4-b308-4cf9-acfb-5267897274fb',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F2.jpg?alt=media&token=4bce9bae-1578-47b5-a25f-9dcb542a786c',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F8.jpg?alt=media&token=a2ca1076-3265-42a9-92a7-624fa7f5b1a2',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F3%20-%20Copy.jpg?alt=media&token=d4c1705d-1baa-460f-9bb5-2a0febc1f809',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F9.jpg?alt=media&token=65b5837f-3bb8-4938-beac-64ef7e53f065',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2FReport%20and%20block%2F6.jpg?alt=media&token=ece961c0-ecf1-4d7e-bcbd-afb5892e235d',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F6.jpg?alt=media&token=2009d634-7ecd-4432-9d16-3a0a77e3c46b',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F2.jpg?alt=media&token=1814bd38-b248-45da-b68d-de2f330d0597',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F3.jpg?alt=media&token=754dbda5-bbd1-4653-a7fc-54c68fd09e04',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F4.jpg?alt=media&token=104ab40e-a361-4d0a-ada4-0686493ad919',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F5.jpg?alt=media&token=818e3dfa-39b5-468d-becc-3b84d10d0a4a',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F1.jpg?alt=media&token=d306270b-b3c5-46d5-a99b-d3908cb377bc',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fothers%2F8.jpg?alt=media&token=39e8194c-0d80-45ae-8741-f31f6c8e7222',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0001.jpg?alt=media&token=7358c00f-7e27-4998-adfb-c61471c282c5',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0004.jpg?alt=media&token=03874a69-e288-4c3d-9036-267b6c52a999',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0005.jpg?alt=media&token=ea15af2f-d9d6-45cc-94b0-bbd286086e57',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0007.jpg?alt=media&token=0b098cee-eab5-47f9-bdb4-272e8ceffe9f',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0008.jpg?alt=media&token=cba7d319-d4fb-4620-9da2-12311f1ba6ee',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FWhatsApp%20Image%202021-07-02%20at%2020.26.20.jpeg?alt=media&token=4b3096ea-4f66-4332-ad8e-cfd9d29c472e',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FWhatsApp%20Image%202021-07-02%20at%2020.26.33.jpeg?alt=media&token=fcb9dc0a-339b-480c-81c3-37a984fc6bf2',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FWhatsApp%20Image%202021-07-02%20at%2020.26.54.jpeg?alt=media&token=49ac12ef-0f46-43f5-b7f9-8afb66fd2002',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0002.jpg?alt=media&token=1ef4e809-2aa0-4fcf-af36-5a34cdb38bbc',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0011.jpg?alt=media&token=4b506bf1-9905-4d79-b480-6ae43b21b802',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FWhatsApp%20Image%202021-07-02%20at%2020.46.46.jpeg?alt=media&token=29f460d7-2c79-46ef-9660-36a131d0cff1',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0017.jpg?alt=media&token=bad71ca0-d227-4cb7-adaf-010e80996308', //55
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0018.jpg?alt=media&token=fb9c9d75-f415-4e0f-b2ad-542f52cb0e51',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0019.jpg?alt=media&token=7d6f0ff2-19fb-4e2f-9bca-456bf4a03ee6',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0020.jpg?alt=media&token=d57631c9-0eb9-4604-9824-3ea2c6644797',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0021.jpg?alt=media&token=0ba7468e-d4e1-4da6-b9a8-3b35a24f7372',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0013.jpg?alt=media&token=4cdefb5d-88b3-426f-95c7-9f964e9a7382',//60
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0014.jpg?alt=media&token=81dca87e-1802-412a-b011-6f0d37a91053',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0015.jpg?alt=media&token=8027acc3-1b47-491a-b0ab-cab649522e06',
  'https://firebasestorage.googleapis.com/v0/b/wanas-7af81.appspot.com/o/help%2Fprofile%2FIMG-20210702-WA0016.jpg?alt=media&token=55e641b2-6af2-4422-8b47-d7d5ed721f1a',
  
];

class Help2 extends StatefulWidget {
  @override
  _Help2State createState() => _Help2State();
}

class _Help2State extends State<Help2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Help',
        ),
        actions: [
          TextButton(
            child: Text(
              'Contact us',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final Email email = Email(
                body:
                    "", //'Hi WanasApp Developers.I have a problem in that email:\n${myid.loggedInUser.email}\n and the problem is..',
                subject: 'WanasApp',
                recipients: ['wanasapp0@gmail.com'],
                isHTML: false,
              );

              await FlutterEmailSender.send(email);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          getExpasionTiles(
            type: 2,
            mainTitle: 'Overall',
            listTile1: 'How to use',
            listTile2: 'Find people',
            page1: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'How to use',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Activities.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[1],
                  ),
                  Text('\n3.Select an activity from activities screen.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[2],
                  ),
                  Text("\n4.Allow Wanas to access your device's location.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[3],
                  ),
                  Text('\n5.Turn on your device location.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[4],
                  ),
                  Text(
                      '\n6.Choose a person which you want to share your intresting activity with.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[5],
                  ),
                  Text(
                      '\n7.You can view his location on the map by pressing on pin icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[9],
                  ),
                  CachedNetworkImage(
                    imageUrl: howToUse[6],
                  ),
                  Text(
                      '\n8.You can start chat with that person by pressing on chat icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[10],
                  ),
                  Text(
                      '\n9.Talk with that person about where and when will you meet to do the chosen activity together.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[11],
                  ),
                ],
              ),
            )),
            page2: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Find people',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      "\nYour only way to find new people is through a common activity between you and them.\n\nSo if you want to find new people do as the following.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "\n1.Drag the screen from the left, or press on navigation menu.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Activities.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[1],
                  ),
                  Text('\n3.Select an activity from activities screen.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[2],
                  ),
                  Text("\n4.Allow Wanas to access your device's location.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[3],
                  ),
                  Text('\n5.Turn on your device location.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[4],
                  ),
                  Text(
                      '\n6.Choose a person which you want to share your intresting activity with.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[5],
                  ),
                  Text(
                      '\nAs you see you are viewing the chosen perosn profile.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[8],
                  ),
                  Text(
                      '\nAlso you can view his location on the map,or chat with him by using pin icon,and chat icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ),
          getExpasionTiles(
              type: 5,
              mainTitle: 'Profile',
              listTile1: 'Profile picture',
              listTile2:  'Cover picture',
              listTile3:  'Remove picture',
              listTile4: 'Block list',
              listTile5: 'Name, Bio, Age',
              page1: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Profile picture',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Press on the camera icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[44],
                  ),
                  Text('\n2.Press on Gallery.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[45],
                  ),
                  Text('\n3.Select a picture from your gallery then press Done.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[46],
                  ),
                  Text("\n4.Wait till the picture is uploaded.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[47],
                  ),
                  Text('\n5.And as you see it have been updated successfully.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[48],
                  ),
                  
                ],
              ),
            )),
              page2: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Cover picture',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Press on the camera icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[52],
                  ),
                  Text('\n2.Press on Gallery.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[45],
                  ),
                  Text('\n3.Select a picture from your gallery then press Done.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[49],
                  ),
                  Text("\n4.Wait till the picture is uploaded.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[50],
                  ),
                  Text('\n5.And as you see it have been updated successfully.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[51],
                  ),
                  
                ],
              ),
            )),
              page3: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Cover picture',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\nAfter pressing on the camera icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  
                  Text('\n1.Press on Remove photo.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[53],
                  ),
                  Text('\n2.And as you see your profile picture is removed successfully.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[54],
                  ),
                  Text("\nAnd you can do the same steps with the cover picture.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
              ),
            )),
              page4: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Block list',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Press on the three dots icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[55],
                  ),
                  Text('\n2.Press on Block list choice.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[56],
                  ),
                  Text('\n3.Select any user to unblock.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[57],
                  ),
                  Text("\n4.Press on unblock.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[58],
                  ),
                  Text('\n5.Press yes to unblock the selected user.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[59],
                  ),
                  
                ],
              ),
            )),
              page5: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Name, Bio, Age',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Press on Edit icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[60],
                  ),
                  Text('\n2.Change your profile info as you want.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[61],
                  ),
                  Text('\n3.Press on update.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[62],
                  ),
                  Text("\n4.And as you see i changed my name easily.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[63],
                  ),
                  
                ],
              ),
            )),
              ),
          getExpasionTiles(
              type: 3,
              mainTitle: 'Activities',
              listTile1: 'Activity selection',
              listTile2: 'Location',
              listTile3: 'View users',
              page1: HowToUse(
                  scaffold: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    'ActivitySelection',
                  ),
                ),
                body: ListView(
                  children: [
                    Text(
                        "\n1.Drag the screen from the left, or press on navigation menu.\n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[0],
                    ),
                    Text('\n2.Press on Activities.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[1],
                    ),
                    Text(
                        '\nYou will find here a long list of interesting activites which you can share and try with alot of new friends using Wanas application.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[12],
                    ),
                  ],
                ),
              )),
              page2: HowToUse(
                  scaffold: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        title: Text(
                          'Location',
                        ),
                      ),
                      body: ListView(
                        children: [
                          Text(
                              '\n After selecting an activity from activities screen a dialog box will appear asking for location usage permission.\n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              "\n1.Allow Wanas to access your device's location.\n",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CachedNetworkImage(
                            imageUrl: howToUse[3],
                          ),
                          Text('\n2.Turn on your device location.\n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CachedNetworkImage(
                            imageUrl: howToUse[4],
                          ),
                        ],
                      ))),
              page3: HowToUse(
                  scaffold: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    'View users',
                  ),
                ),
                body: ListView(
                  children: [
                    Text(
                        '\n1.Choose a person which you want to share your intresting activity with.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[5],
                    ),
                    Text(
                        '\nAs you see by pressing on any user in the activity screen which you have selected you will be navigated to his profile.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[8],
                    ),
                    Text(
                        '\n2.You can view his location on the map by pressing on pin icon.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[9],
                    ),
                    CachedNetworkImage(
                      imageUrl: howToUse[6],
                    ),
                    Text(
                        '\n3.You can start chat with that person by pressing on chat icon.\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CachedNetworkImage(
                      imageUrl: howToUse[10],
                    ),
                  ],
                ),
              ))),
          getExpasionTiles(
            type: 5,
            mainTitle: 'Chats',
            listTile1: 'Chats',
            listTile2: 'Clear chat',
            listTile3: 'Delete chat',
            listTile4: 'Report',
            listTile5: 'Block',
            page1: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Chats',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Chats.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[13],
                  ),
                  Text("\nAs you see, you have no chats.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[15],
                  ),
                  Text(
                      "\nYou should know that your only way to find new people is through a common activity or a common interest between you and them.So if you want to find new people do as the following.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "\n1.Drag the screen from the left, or press on navigation menu.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[14],
                  ),
                  Text('\n2.Press on Activities.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[1],
                  ),
                  Text('\n3.Select an activity from activities screen.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[2],
                  ),
                  Text("\n4.Allow Wanas to access your device's location.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[3],
                  ),
                  Text('\n5.Turn on your device location.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[4],
                  ),
                  Text(
                      '\n6.Choose a person which you want to share your intresting activity with.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[5],
                  ),
                  Text(
                      '\nAs you see you are viewing the chosen perosn profile.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[8],
                  ),
                  Text(
                      '\n7.You can start chat with that person by pressing on chat icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[10],
                  ),
                  Text(
                      '\n8.Talk with that person about where and when will you meet to do the chosen activity together.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[7],
                  ),
                  Text('\n9.Check your chats again.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[16],
                  ),
                ],
              ),
            )),
            page2: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Clear chats',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Chats.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[13],
                  ),
                  Text('\n3.Select any chat.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[17],
                  ),
                  Text('\n4.press on view more icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[18],
                  ),
                  Text(
                      '\n5.If you want to just clear the messages and keep the user chat for another conversation just select Clear chat from that menu\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[19],
                  ),
                  Text(
                      '\n6.If you pressed yes the chat will be cleared as you see\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[20],
                  ),
                  CachedNetworkImage(
                    imageUrl: howToUse[21],
                  ),
                ],
              ),
            )),
            page3: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Delete chats',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Chats.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[13],
                  ),
                  Text('\n3.Select any chat.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[17],
                  ),
                  Text('\n4.press on view more icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[18],
                  ),
                  Text(
                      "\n5.If you want to just clear messages and delete user's conversation select Delete chat from that menu.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[22],
                  ),
                  Text('\n6.If you pressed yes the chat will be Deleted\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[24],
                  ),
                  Text('\nAs you see the chat has been deleted\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[23],
                  ),
                ],
              ),
            )),
            page4: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Report',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Chats.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[13],
                  ),
                  Text('\n3.Select any chat.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[25],
                  ),
                  Text('\n4.press on view more icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[26],
                  ),
                  Text('\n5.Select Block from the menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[27],
                  ),
                  Text('\n6.press on Report reason.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[28],
                  ),
                  Text('\n7.Select the report reason.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[29],
                  ),
                  Text('\n8.Press yes to report that user.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[30],
                  ),
                  Text('\nReported Successfully.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[31],
                  ),
                  Text('\n8.Check the chat of the reported user again.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[32],
                  ),
                  Text("\nBoth of you can't chat each other again\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[33],
                  ),
                ],
              ),
            )),
            page5: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Block',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text('\n2.Press on Chats.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[13],
                  ),
                  Text('\n3.Select any chat.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[25],
                  ),
                  Text('\n4.press on view more icon.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[26],
                  ),
                  Text('\n5.Select Block from the menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[34],
                  ),
                  Text('\n6.Press yes to block that user.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[35],
                  ),
                  Text("\nCheck your chats again\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[36],
                  ),
                  Text(
                      "\nAs you see, user is blocked successfully and also the chat is removed",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ),
          getExpasionTiles(
            type: 3,
            mainTitle: 'Others',
            listTile1: 'Rating',
            listTile2: 'Banned?',
            listTile3: 'Contact us',
            page1: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Rating',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      "\n1.Drag the screen from the left, or press on navigation menu.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text("\n2.Press on Rating.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[37],
                  ),
                  Text("\n3.Tap the pencil icon.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[38],
                  ),
                  Text(
                      "\n4.Write your opinion in the textfield,give some stars,and press on Submit.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[39],
                  ),
                  Text("\nYour opinion added successfully as you see.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[40],
                  ),
                ],
              ),
            )),
            page2: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Banned?',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      "\nIf you was a bad user and a bothering one, this message will appeare notifing you that you have reached the maximum number of reports and you are Banned.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[41],
                  ),
                  Text("\nWhat can you do?\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "You can contact us by sending an Email explaining your problem if you are innocent,but if you are guilty it's better to fix yourself.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[42],
                  ),
                ],
              ),
            )),
            page3: HowToUse(
                scaffold: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Contact us',
                ),
              ),
              body: ListView(
                children: [
                  Text(
                      '\n1.Drag the screen from the left, or press on navigation menu.\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[0],
                  ),
                  Text(
                      "\nYou can contact us by sending an Email explaining your problem or for any other reasone.\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[42],
                  ),
                  Text("\nFor example...\n",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CachedNetworkImage(
                    imageUrl: howToUse[43],
                  ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  getExpasionTiles(
      {int type,
      String mainTitle,
      String listTile1,
      String listTile2,
      String listTile3,
      String listTile4,
      String listTile5,
      page1,
      page2,
      page3,
      page4,
      page5}) {
    if (type == 1) {
      return ExpansionTile(
        title: Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(listTile1),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page1, x: 1.0));
              }),
        ],
      );
    } else if (type == 2) {
      return ExpansionTile(
        title: Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(listTile1),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page1, x: 1.0));
              }),
          ListTile(
              title: Text(listTile2),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page2, x: 1.0));
              }),
        ],
      );
    } else if (type == 3) {
      return ExpansionTile(
        title: Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(listTile1),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page1, x: 1.0));
              }),
          ListTile(
              title: Text(listTile2),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page2, x: 1.0));
              }),
          ListTile(
              title: Text(listTile3),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page3, x: 1.0));
              }),
        ],
      );
    } else if (type == 4) {
      return ExpansionTile(
        title: Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(listTile1),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page1, x: 1.0));
              }),
          ListTile(
              title: Text(listTile2),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page2, x: 1.0));
              }),
          ListTile(
              title: Text(listTile3),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page3, x: 1.0));
              }),
          ListTile(
              title: Text(listTile4),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page4, x: 1.0));
              }),
        ],
      );
    } else if (type == 5) {
      return ExpansionTile(
        title: Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(listTile1),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page1, x: 1.0));
              }),
          ListTile(
              title: Text(listTile2),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page2, x: 1.0));
              }),
          ListTile(
              title: Text(listTile3),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page3, x: 1.0));
              }),
          ListTile(
              title: Text(listTile4),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page4, x: 1.0));
              }),
          ListTile(
              title: Text(listTile5),
              onTap: () {
                Navigator.of(context).push(SlidePosition(page: page5, x: 1.0));
              }),
        ],
      );
    }
  }
}

class HowToUse extends StatelessWidget {
  final Widget scaffold;
  HowToUse({this.scaffold});
  @override
  Widget build(BuildContext context) {
    return scaffold;
  }
}
