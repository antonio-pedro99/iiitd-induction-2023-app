import 'package:btech_induction_2023/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/user.dart';

class FirebaseAuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  
   _googleSignIn.disconnect();
     _currentUser = null;
    notifyListeners();
  }

  Future<void> signUpWithGoogle() async {
    try {
     
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return;
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _currentUser = userCredential.user;
      notifyListeners();
    } catch (exception) {
      print(exception);
    }
  }
}

class FirebaseFirestoreService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUserData(UserProfile userProfile) async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set(userProfile.toMap());
    } catch (exception) {
      print(exception);
    }
  }
}
