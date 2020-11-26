import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:E_Pal/utils/size_config.dart';
import 'package:E_Pal/pages/modals/profile_modal.dart';
import 'package:E_Pal/pages/modals/filter_modal.dart';
import 'package:E_Pal/pages/modals/sortBy_modal.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:E_Pal/services/firestore_service.dart';
import 'package:E_Pal/utils/constant.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  //Scroll
  ScrollController userListController = ScrollController();
  bool categoryIsClosed = false;
  int selectedGameIndex;
  String selectedGame;

  //Audio
  AudioPlayer audioPlugin = AudioPlayer();
  String audioUrl =
      "https://www.mediacollege.com/downloads/sound-effects/electronics/phone/Phone_01_Preview.mp3";
  int currentlyPlaying;

  @override
  void initState() {
    super.initState();
    selectedGameIndex = 0; //Implement Favorites.
    userListController.addListener(() {
      setState(() {
        categoryIsClosed = userListController.offset > 40;
      });
    });
  }

  //Voice Message Play
  void playVoiceMessage(int index) {
    if (currentlyPlaying == null || currentlyPlaying != index) {
      setState(() {
        audioPlugin.stop();
        currentlyPlaying = index;
        audioPlugin.play(audioUrl, isLocal: false);
        print("Currently playing Voice Message n. $currentlyPlaying");
      });
    } else {
      setState(() {
        currentlyPlaying = null;
        audioPlugin.stop();
        print("No Voice Message currently playing.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig.
    SizeConfig().init(context);

    //Need Firestore Instance in order to pass it to the Modal Bottom Sheet.
    final firestore = FirestoreService(
        context.watch<FirestoreService>().firestore,
        context.watch<FirestoreService>().userEmail);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MdiIcons.faceProfile,
            color: Colors.white70,
          ),
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Provider(
                create: (context) {
                  return firestore;
                },
                child: ProfileModalNavigator(),
              ),
            );
          },
        ),
        title: Text(
          "Explore",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Column(
            children: [
              //Game List View (Horizontal)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height:
                    categoryIsClosed ? 0 : SizeConfig.safeBlockVertical * 20,
                margin:
                    EdgeInsets.symmetric(vertical: categoryIsClosed ? 0 : 10),
                child: FutureBuilder(
                  future: context
                      .watch<FirestoreService>()
                      .getCollectionDocs('games'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          //Get Images from Firebase.
                          return Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              height: selectedGameIndex == index
                                  ? SizeConfig.safeBlockVertical * 20
                                  : SizeConfig.safeBlockVertical * 18,
                              width: selectedGameIndex == index
                                  ? SizeConfig.safeBlockVertical * 20
                                  : SizeConfig.safeBlockVertical * 18,
                              child: index < snapshot.data.length
                                  ? GestureDetector(
                                      onTap: () {
                                        print("Game $index Selected.");
                                        setState(() {
                                          selectedGameIndex = index;
                                          selectedGame = snapshot
                                              .data[selectedGameIndex]['name'];
                                        });
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: PrimaryTheme,
                                            width: selectedGameIndex == index
                                                ? 2
                                                : 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snapshot.data[index]
                                                  ['photoUrl'],
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                color: Colors.black45,
                                                height: SizeConfig
                                                        .safeBlockVertical *
                                                    4,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 5,
                                                            right: 5,
                                                          ),
                                                          child: AutoSizeText(
                                                            snapshot.data[index]
                                                                ['name'],
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                            maxLines: 1,
                                                            minFontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        print("More Games Selected.");
                                        Navigator.of(context).pushNamed(
                                          GamesRoute,
                                          arguments: context,
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          MdiIcons.plusCircle,
                                          size:
                                              SizeConfig.safeBlockVertical * 6,
                                          color: PrimaryTheme,
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                              backgroundColor: PrimaryTheme),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                child: categoryIsClosed ? Container() : Divider(height: 0),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Filter Pressed.");
                          showCupertinoModalBottomSheet(
                            topRadius: Radius.circular(25),
                            expand: false,
                            context: context,
                            builder: (context) => FilterModal(
                              category: "test",
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              MdiIcons.filter,
                              color: PrimaryTheme,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Filter",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: PrimaryTheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Sort By Pressed.");
                          showCupertinoModalBottomSheet(
                            topRadius: Radius.circular(25),
                            expand: false,
                            context: context,
                            builder: (context) => SortByModal(),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "Sort By",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: PrimaryTheme,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              MdiIcons.sortVariant,
                              color: PrimaryTheme,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //User ListView (Vertical)
              Expanded(
                child: FutureBuilder(
                    future: context
                        .watch<FirestoreService>()
                        .getCollectionDocs('pals'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          //Get Data From Firebase
                          controller: userListController,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth,
                                  height: SizeConfig.safeBlockVertical * 12,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        //Image Card
                                        Card(
                                          color: Colors.transparent,
                                          semanticContainer: true,
                                          elevation: 1,
                                          margin: EdgeInsets.all(5),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: snapshot.data[index]
                                                      ['photoUrl'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  width: (SizeConfig
                                                              .safeBlockVertical *
                                                          12) -
                                                      10, //Need -10 because there is 10 Pixels of Margin.
                                                  imageUrl: snapshot.data[index]
                                                      ['photoUrl'],
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  width: (SizeConfig
                                                              .safeBlockVertical *
                                                          12) -
                                                      10, //Need -10 because there is 10 Pixels of Margin.
                                                  child: Image.asset(
                                                    "assets/images/avatar.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                        //User Information Section
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index]['name'] ??
                                                  "User",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  MdiIcons.starBox,
                                                  color: AccentTheme,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  snapshot.data[index]['rating']
                                                          .toString() ??
                                                      "0.0",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "(${snapshot.data[index]['reviews'].toString()})" ??
                                                      "0",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  MdiIcons.currencyKrw,
                                                  color: PrimaryTheme,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  snapshot.data[index]['price']
                                                          .toString() ??
                                                      "Free",
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        //Voice Message
                                        GestureDetector(
                                          onTap: () {
                                            print("Voice Message Pressed.");
                                            playVoiceMessage(index);
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Container(
                                              height:
                                                  SizeConfig.safeBlockVertical *
                                                      4.5,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  17,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: PrimaryTheme,
                                              ),
                                              child: currentlyPlaying != index
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.keyboard_voice,
                                                          color: Colors.white,
                                                        ),
                                                        Icon(
                                                          MdiIcons.play,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    )
                                                  : Center(
                                                      child: Lottie.asset(
                                                          "assets/lottie/2671-sound-visualizer.json"),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                                backgroundColor: PrimaryTheme),
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
