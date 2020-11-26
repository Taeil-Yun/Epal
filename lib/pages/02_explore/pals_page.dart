import 'package:E_Pal/services/firestore_service.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PalsPage extends StatelessWidget {
  final BuildContext rootContext;
  const PalsPage({this.rootContext, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootContext.watch<FirestoreService>().getCollectionDocs('pals'),
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
                "E-Pals",
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
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      snapshot.data[index]['photoUrl'],
                      fit: BoxFit.cover,
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
