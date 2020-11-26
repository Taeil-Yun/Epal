import 'package:E_Pal/services/firestore_service.dart';
import 'package:E_Pal/utils/constant.dart';
import 'package:E_Pal/utils/size_config.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GamesPage extends StatelessWidget {
  final BuildContext rootContext;
  const GamesPage({this.rootContext, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder(
      future: rootContext.watch<FirestoreService>().getCollectionDocs('games'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: PrimaryTheme,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white70,
              ),
              title: Text(
                "All Games",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            body: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                snapshot.data.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      print("Game Tapped.");
                      Navigator.of(context).pushNamed(
                        UsersRoute,
                        arguments: rootContext,
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            snapshot.data[index]['photoUrl'],
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 5,
                              color: Colors.black45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        snapshot.data[index]['name'],
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: PrimaryTheme,
            body: Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
