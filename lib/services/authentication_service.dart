import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  //Firebase Authentication
  final FirebaseAuth _firebaseAuth;
  //Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  String get emailAddress => _firebaseAuth.currentUser.email;

  Future<bool> get emailVerified async {
    await _firebaseAuth.currentUser.reload();
    return _firebaseAuth.currentUser.emailVerified;
  }

  //Sign In
  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("---Authentication: Signed In.");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<void> onAuthenticationSuccessful(UserCredential credentials) async {
    final firebaseUser = credentials.user;
    final userId = firebaseUser.uid;

    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(
            "The authenticated user is present in the database. Logging in...");
      } else {
        print(
            "The authenticated user is not present in the database. Creating user...");
        _firestore
            .collection('users')
            .add({
              'email': credentials.user.email,
              'name': '',
              'photoUrl': '',
              'backgroundPhotoUrl': '',
              'gender': '',
              'biography': '',
              'language': '',
              'followers': 0,
              'following': 0,
            })
            .then((_) => print("User Added."))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  //Send Verification Email
  Future<void> sendVerificationEmail() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
    print("---Authentication: Verification Email sent to $emailAddress");
  }

  //Sign Up
  Future<String> signUp(String email, String password) async {
    try {
      //Create User on Firebase upon successful registration.
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential credentials) async {
        if (credentials != null && credentials.user != null) {
          await onAuthenticationSuccessful(credentials);
        }
        print(credentials.user);
      });
      print("---Authentication: Signed Up.");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  //Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print("---Authentication: Signed Out.");
  }
}
