import 'package:E_Pal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:E_Pal/utils/size_config.dart';
import 'package:E_Pal/services/authentication_service.dart';
import 'package:E_Pal/utils/constant.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    FToast fToast = FToast();
    fToast.init(context);

    _showToast(String text) {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: AccentTheme,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.email,
              color: Colors.white,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              text,
            ),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    }

    return Container(
      color: PrimaryTheme,
      child: Center(
        child: Container(
          height: SizeConfig.safeBlockVertical * 98, //100%
          width: SizeConfig.blockSizeHorizontal * 95,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            //85%
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                //20%
                Container(
                  child: Lottie.asset(
                    "assets/lottie/12135-email-send.json",
                    height: SizeConfig.safeBlockVertical * 20,
                    width: SizeConfig.safeBlockVertical * 20,
                  ),
                ),
                //7%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                //5%
                Container(
                  height: SizeConfig.safeBlockVertical * 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "CONFIRM YOUR EMAIL ADDRESS",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                //10%
                Container(
                  height: SizeConfig.safeBlockVertical * 9,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Center(
                    child: Text(
                      "We sent an email to ${context.watch<AuthenticationService>().emailAddress}. Please check your Inbox and find the confirmation email we've sent you.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 15),
                    ),
                  ),
                ),
                //5%
                Container(
                  height: SizeConfig.safeBlockVertical * 6,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Center(
                    child: Text(
                      "If you cannot find the email within your Inbox, please check your Spam folder.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 15),
                    ),
                  ),
                ),
                //5%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                Divider(),
                //5%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                //5%
                Container(
                  height: SizeConfig.safeBlockVertical * 6,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Center(
                    child: Text(
                      "After your email is confirmed, return to this page to continue.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 15),
                    ),
                  ),
                ),
                //5%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                //5%
                Container(
                  height: SizeConfig.safeBlockVertical * 5,
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: RaisedButton(
                    splashColor: PrimaryTheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      context.read<AuthenticationService>().emailVerified.then(
                        (verified) async {
                          if (verified) {
                            await Navigator.pushReplacementNamed(
                                context, HomeRoute);
                          } else {
                            _showToast("Please confirm your email address.");
                          }
                        },
                      );
                    },
                    child: Text(
                      "Proceed",
                    ),
                  ),
                ),
                //3%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                //5%
                Container(
                  height: SizeConfig.safeBlockVertical * 6,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Column(
                    children: [
                      Text(
                        "Didn't receive the email?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _showToast("Verification Email has been sent.");
                          await context
                              .read<AuthenticationService>()
                              .sendVerificationEmail();
                        },
                        child: Text(
                          "RESEND",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //10%
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
