import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:E_Pal/services/authentication_service.dart';
import 'package:E_Pal/pages/home_page.dart';
import 'package:E_Pal/pages/01_authentication/authentication_page.dart';
import 'package:E_Pal/utils/constant.dart';
import 'package:E_Pal/pages/02_explore/games_page.dart';
import 'package:E_Pal/pages/02_explore/pals_page.dart';
import 'package:E_Pal/pages/03_match/match_page.dart';
import 'package:E_Pal/pages/01_authentication/verification_page.dart';
import 'package:E_Pal/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
      ],
      child: MaterialApp(
        title: 'E-Pal',
        theme: ThemeData(
          primaryColor: PrimaryTheme,
          accentColor: AccentTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        debugShowCheckedModeBanner: false,
        routes: {
          // When navigating to the "/$" route, build the () widget.
          '$AuthenticationRoute': (context) => AuthenticationPage(),
          '$VerificationRoute': (context) => VerificationPage(),
          '$HomeRoute': (context) => HomePage(),
          '$MatchRoute': (context) => MatchPage(),
          '$GamesRoute': (context) =>
              GamesPage(rootContext: ModalRoute.of(context).settings.arguments),
          '$UsersRoute': (context) =>
              PalsPage(rootContext: ModalRoute.of(context).settings.arguments),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: context.watch<AuthenticationService>().authStateChanges.first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); //Implement CircularProgressIndicator Page.
        } else {
          if (snapshot.hasData && snapshot.data.emailVerified) {
            return HomePage();
          } else {
            return AuthenticationPage();
          }
        }
      },
    );
  }
}
