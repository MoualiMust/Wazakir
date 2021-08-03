import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wazakir/services/firestoreService.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseFirestore.instance.collection('users');

  Future<String> signUpWithEmailPassword(
      String email, String motDePass, String nom) async {
    String res = '';
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: motDePass)
          .then((value) async {
        await FireStoreService().saveUser(nom).then((value) => res = 'succes');
      });
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return e.code;
    }
    return res;
  }

  Future<String> loginWithEmailPassword(String email, String motDePass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: motDePass);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return e.code;
    }
    return 'succes';
  }

  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return e.code;
    }
    return 'succes';
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
  }

  Future<void> deleteUser() async {
    await _auth.currentUser.delete();
  }
}
