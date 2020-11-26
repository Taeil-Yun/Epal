import 'package:E_Pal/services/authentication_service.dart';
import 'package:E_Pal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:E_Pal/utils/constant.dart';

class AuthenticationPage extends StatelessWidget {
  bool isSigningIn;
  bool isEmailVerified;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FlutterLogin(
        theme: LoginTheme(
          primaryColor: PrimaryTheme,
          accentColor: AccentTheme,
          titleStyle: GoogleFonts.quicksand(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyStyle: GoogleFonts.quicksand(),
          textFieldStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
          ),
          inputTheme: InputDecorationTheme(
            filled: true,
            errorStyle: GoogleFonts.quicksand(),
          ),
          errorColor: AccentTheme,
          buttonStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
          ),
        ),
        messages: LoginMessages(
          signupButton: "REGISTER",
        ),
        //logo: , //TODO: Create Logo.
        title: "E-Pal",
        onLogin: (LoginData data) async {
          isSigningIn = true;

          return await context
              .read<AuthenticationService>()
              .signIn(data.name, data.password)
              .then((errorMessage) async {
            if (errorMessage == null) {
              await context
                  .read<AuthenticationService>()
                  .emailVerified
                  .then((verified) async {
                isEmailVerified = verified;
                if (!isEmailVerified) {
                  await context
                      .read<AuthenticationService>()
                      .sendVerificationEmail();
                }
              });
            }
            return errorMessage;
          });
        },
        onSignup: (LoginData data) async {
          isSigningIn = false;

          return await context
              .read<AuthenticationService>()
              .signUp(
                data.name,
                data.password,
              )
              .then((errorMessage) async {
            if (errorMessage == null) {
              await context
                  .read<AuthenticationService>()
                  .sendVerificationEmail();
            }
            return errorMessage;
          });
        },
        onSubmitAnimationCompleted: () async {
          //User Sign In (Email Verified)
          if (isSigningIn && isEmailVerified) {
            await Navigator.pushNamedAndRemoveUntil(
                context, HomeRoute, (Route<dynamic> route) => false);
          }
          //User Sign In (Email Not Verified)
          // Or
          //User Sign Up
          else {
            await Navigator.pushNamedAndRemoveUntil(
                context, VerificationRoute, (Route<dynamic> route) => false);
          }
        },
        onRecoverPassword: (String password) {
          return Future.value(
              password); //TODO: Implement onRecoverPassword function.
        },
      ),
    );
  }
}
