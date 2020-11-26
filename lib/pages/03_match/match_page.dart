import 'package:E_Pal/utils/size_config.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: PrimaryTheme,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),
        title: Text(
          "E-Pal Matching",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  "assets/lottie/301-search-location.json",
                  height: SizeConfig.safeBlockVertical * 35,
                  width: SizeConfig.safeBlockVertical * 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
