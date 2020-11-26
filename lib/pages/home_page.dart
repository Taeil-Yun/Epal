import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:E_Pal/services/authentication_service.dart';
import 'package:E_Pal/services/firebase_storage_service.dart';
import 'package:E_Pal/pages/04_chat/chat_page.dart';
import 'package:E_Pal/pages/02_explore/explore_page.dart';
import 'package:E_Pal/services/firestore_service.dart';
import 'package:E_Pal/utils/constant.dart';
import 'package:E_Pal/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Animation Properties
  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curve;

  final iconList = <IconData>[
    MdiIcons.compass,
    MdiIcons.chat,
  ];

  int _pageIndex;

  final List<Widget> _pages = [
    ExplorePage(),
    ChatPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;

    //Animation Init()
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0,
        1,
        curve: Curves.decelerate,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_curve);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(
          create: (_) => FirestoreService(FirebaseFirestore.instance,
              context.read<AuthenticationService>().emailAddress),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        )
      ],
      child: Scaffold(
        backgroundColor: PrimaryTheme,
        body: IndexedStack(
          //Without IndexedStack the page would be rebuilt every time you change page using the bottom navigation bar.
          index: _pageIndex,
          children: _pages,
        ),
        floatingActionButton: ScaleTransition(
          scale: _animation,
          child: FloatingActionButton(
            elevation: 0,
            child: Icon(
              MdiIcons.gamepadVariant,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(MatchRoute);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          elevation: 0,
          icons: iconList,
          backgroundColor: PrimaryTheme,
          activeIndex: _pageIndex,
          activeColor: Colors.white54,
          splashColor: AccentTheme,
          inactiveColor: Colors.white,
          notchAndCornersAnimation: _animation,
          splashSpeedInMilliseconds: 200,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          /* leftCornerRadius: 45,
          rightCornerRadius: 45, */
          onTap: (index) => setState(() => _pageIndex = index),
        ),
      ),
    );
  }
}
