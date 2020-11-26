import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:E_Pal/utils/size_config.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:E_Pal/services/firestore_service.dart';

class ProfileModalNavigator extends StatefulWidget {
  const ProfileModalNavigator({Key key}) : super(key: key);

  @override
  _ProfileModalNavigatorState createState() => _ProfileModalNavigatorState();
}

class _ProfileModalNavigatorState extends State<ProfileModalNavigator> {
  File _image;
  final picker = ImagePicker();

  //Get Image from Image Library.
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    //..
    //Implement Image Picker.
    //..

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext rootContext) {
    SizeConfig().init(rootContext);

    //Build with FutureBuilder
    return FutureBuilder(
      future: rootContext.watch<FirestoreService>().getUserInformations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: SizeConfig.safeBlockVertical * 80,
            child: Material(
                child: Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (context2) => Builder(
                  builder: (context) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text(
                        snapshot.data['name'] == ''
                            ? snapshot.data['email']
                            : snapshot.data['name'],
                        style: GoogleFonts.quicksand(fontSize: 19),
                      ),
                    ),
                    child: SafeArea(
                      //bottom: false,
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 2,
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: SizeConfig.safeBlockVertical * 14,
                                  width: SizeConfig.safeBlockVertical * 14,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: snapshot.data['photoUrl'] != ''
                                          ? CachedNetworkImageProvider(
                                              snapshot.data['photoUrl'])
                                          : AssetImage(
                                              'assets/images/avatar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: PrimaryTheme,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(MdiIcons.camera,
                                          color: Colors.white),
                                      onPressed: () {
                                        print("Camera Icon Pressed.");
                                        //Get Image from Image Library.
                                        getImage();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1.5,
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                height: SizeConfig.safeBlockVertical * 30,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 10),
                                child: GridView.count(
                                  physics: ClampingScrollPhysics(),
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  crossAxisCount: 2,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        /* Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CupertinoPageScaffold(
                                                  navigationBar:
                                                      CupertinoNavigationBar(
                                                    leading: IconButton(
                                                      icon: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: PrimaryTheme,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    middle: Text(
                                                      'Profile',
                                                      style: GoogleFonts
                                                          .quicksand(),
                                                    ),
                                                    trailing: IconButton(
                                                      icon: Icon(
                                                        MdiIcons.closeCircle,
                                                        color: PrimaryTheme,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(
                                                                rootContext)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                  child: Text("test"),
                                                ),
                                              ),
                                            ); */
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MdiIcons.account,
                                                color: PrimaryTheme,
                                                size: SizeConfig
                                                        .safeBlockVertical *
                                                    8,
                                              ),
                                              AutoSizeText(
                                                "Profile",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  //fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        /* Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CupertinoPageScaffold(
                                              navigationBar:
                                                  CupertinoNavigationBar(
                                                leading: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                middle: Text(
                                                  'Become an E-Pal',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    MdiIcons.closeCircle,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(rootContext)
                                                        .pop();
                                                  },
                                                ),
                                              ),
                                              child: Text("test"),
                                            ),
                                          ),
                                        ); */
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MdiIcons.gamepadVariant,
                                                color: PrimaryTheme,
                                                size: SizeConfig
                                                        .safeBlockVertical *
                                                    8,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: AutoSizeText(
                                                  "E-Pal",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    //fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        /* Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CupertinoPageScaffold(
                                              navigationBar:
                                                  CupertinoNavigationBar(
                                                leading: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                middle: Text(
                                                  'Wallet',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    MdiIcons.closeCircle,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(rootContext)
                                                        .pop();
                                                  },
                                                ),
                                              ),
                                              child: Text("test"),
                                            ),
                                          ),
                                        ); */
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MdiIcons.wallet,
                                                color: PrimaryTheme,
                                                size: SizeConfig
                                                        .safeBlockVertical *
                                                    8,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: AutoSizeText(
                                                  "Wallet",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    //fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        /* Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CupertinoPageScaffold(
                                              navigationBar:
                                                  CupertinoNavigationBar(
                                                leading: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                middle: Text(
                                                  'Settings',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    MdiIcons.closeCircle,
                                                    color: PrimaryTheme,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(rootContext)
                                                        .pop();
                                                  },
                                                ),
                                              ),
                                              child: Text("test"),
                                            ),
                                          ),
                                        ); */
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.settings,
                                                color: PrimaryTheme,
                                                size: SizeConfig
                                                        .safeBlockVertical *
                                                    8,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: AutoSizeText(
                                                  "Settings",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    //fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.safeBlockVertical * 0.5),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.quicksand(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: '~'),
                                    TextSpan(
                                      text: 'Never ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: PrimaryTheme),
                                    ),
                                    TextSpan(
                                      text: 'battle alone~',
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 1)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          );
        } else {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(backgroundColor: PrimaryTheme),
            ),
          );
        }
      },
    );
  }
}
