import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanas/my/menu.dart';

class Testo extends StatefulWidget {
  @override
  _TestoState createState() => _TestoState();
}

class _TestoState extends State<Testo> {
  @override
  Widget build(BuildContext context) {
    var photo = '';
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              
                Container(
                color:Colors.red,
                height:MediaQuery.of(context).size.height *0.34 ,
                width:MediaQuery.of(context).size.width *1.0,
                child: Image.asset('assets/defProfile.jpg'),
                ),
                
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Content goes here'),
                  ),
                ),
              )
            ],
            
          ),
          // Profile image
          Positioned(
            top: MediaQuery.of(context).size.width *0.32, // (background container size) - (circle height / 2)
            child: photo.length == 0
                ? GestureDetector(
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'defHero',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/defProfile.jpg'),
                            ),
                          ),
                        ),
                        radius: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return HeroProfile(number: widget.number);
                      }));
                    })
                : GestureDetector(
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'profileHero',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(photo),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            right:MediaQuery.of(context).size.width *0.02,
            top: MediaQuery.of(context).size.height *0.25,
            child:Container(
              height:MediaQuery.of(context).size.width *0.12 ,
                width:MediaQuery.of(context).size.width *0.12,
              child: IconButton(
                icon:Icon(Icons.camera_alt,
                size:MediaQuery.of(context).size.width *0.07,
                ),
                color:Colors.white,
                onPressed: (){
                  print('hello');
                },
              ),
              decoration: BoxDecoration(
             shape: BoxShape.circle,
              color:Colors.black,
              
            ),
            ),
          ),
          Positioned(
            left:MediaQuery.of(context).size.width *0.60,
            top: MediaQuery.of(context).size.height *0.38,
            child:Container(
              height:MediaQuery.of(context).size.width *0.12 ,
                width:MediaQuery.of(context).size.width *0.12,
              child: IconButton(
                icon:Icon(Icons.camera_alt,
                color:Colors.white,
                size:MediaQuery.of(context).size.width *0.07,
                ),
                color:Colors.black,
                onPressed: (){
                  print('hello');
                },
              ),
              decoration: BoxDecoration(
             shape: BoxShape.circle,
              color:Colors.black,
            ),
            ),
          ),
        ],
      ),
    );
  }
}

/*0.
Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                              Container(
                                color: Colors.red,
                                height:
                                    MediaQuery.of(context).size.height * 0.34,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: Image.asset('assets/menuLogo.jpg'),
                              ),
                              photo.length == 0
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/defProfile.jpg'),
                                          ),
                                        ),
                                      ),
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                    )
                                  : GestureDetector(
                                      child: Hero(
                                        transitionOnUserGestures: true,
                                        tag: 'profileHero',
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        photo),
                                              ),
                                            ),
                                          ),
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return HeroProfile(
                                              photo: photo,
                                              number: widget.number);
                                        }));
                                      }),
                              widget.hisid == null
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                          _showEditPanel(EditProfilePicture());
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(''),
*/