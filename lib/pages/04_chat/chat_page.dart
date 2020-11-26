import 'package:E_Pal/pages/modals/profile_modal.dart';
import 'package:E_Pal/services/authentication_service.dart';
import 'package:E_Pal/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              topRadius: Radius.circular(30),
              expand: false,
              context: context,
              builder: (context) => ProfileModalNavigator(),
            );
          },
        ),
        title: Text(
          "Chat",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              MdiIcons.exitToApp,
              color: Colors.white70,
            ),
            onPressed: () async {
              await context.read<AuthenticationService>().signOut();
              await Navigator.pushReplacementNamed(
                context,
                AuthenticationRoute,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          "Chat Page",
          style: GoogleFonts.quicksand(),
        ),
      ),
    );
  }
}
