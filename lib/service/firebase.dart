import 'dart:io';

import 'package:btech_induction_2023/data/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/event.dart';
import '../data/user.dart';

class FirebaseAuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      rethrow;
    }
  }
}

class FirebaseFirestoreService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserProfile? userProfile;

  Future<void> addUserData(UserProfile userProfile) async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set(userProfile.toMap());
    } catch (exception) {
      rethrow;
    }
  }

  Future<UserProfile?> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserProfile.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (exception) {
      return null;
    }
  }

  Future<Schedule> getScheduledEvents(String day) async {
    try {
      final doc = await _firestore.collection("schedules").doc(day).get();

      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<Event>> getEvents() {
    try {
      return _firestore.collection("events").get().then(
          (value) => value.docs.map((e) => Event.fromJson(e.data())).toList());
    } catch (exception) {
      rethrow;
    }
  }
}

class FirebaseStorageService extends ChangeNotifier {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isUploading = false;

  Future<String> uploadProfilePicture(String filePath) async {
    try {
      notifyListeners();
      _isUploading = true;
      notifyListeners();
      Reference reference = _firebaseStorage
          .ref()
          .child("profile_pictures")
          .child(_auth.currentUser!.uid);

      UploadTask uploadTask = reference.putFile(File(filePath));

      TaskSnapshot taskSnapshot = await uploadTask;
      _isUploading = false;
      notifyListeners();
      return await taskSnapshot.ref.getDownloadURL();
    } catch (exception) {
      rethrow;
    }
  }

  bool get isUploading => _isUploading;
}
