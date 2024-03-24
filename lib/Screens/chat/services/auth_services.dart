import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  /// get instance of auth and firestore
 final  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get current user
 User? getCurrentUser(){
   return _firebaseAuth.currentUser;
 }

  /// sign in
  Future<UserCredential> signInWithEmailandPassword(
      String email, password) async {
    try {
      /// sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );

      /// save user info if it doesn't already exists
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      }, SetOptions(merge: true));

      return userCredential;
    }

    /// catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// create a new user (Sign up)
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email,
          password: password);

      /// after creating the user , create a new document for the user in the users collection
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  /// sign user out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

}
