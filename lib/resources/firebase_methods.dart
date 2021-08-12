import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/modals/weight.dart';
import 'package:weight_app/screens/sign_in_screen.dart';
import 'package:weight_app/utils/services.dart';

class FirebaseMethods {
  static final _auth = FirebaseAuth.instance;
  static final _dbRef = FirebaseFirestore.instance.collection('items');
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  static Future<User?> signIn() async {
    CustomServices.showLoading();
    try {
      UserCredential user = await _auth.signInAnonymously();

      return user.user;
    } catch (e) {
      return null;
    }
  }

  static signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SignInScreen()), (route) => false);
  }

  static addItemToDB(WeightModal weightModal) async {
    CustomServices.showLoading();
    await _dbRef.doc(weightModal.id).set(weightModal.toMap(weightModal));
    CustomServices.dismissLoading();
  }

  static delete(String id) async {
    CustomServices.showLoading();
    await _dbRef.doc(id).delete();
    CustomServices.dismissLoading();
  }

  static updateWeight(String id, String weight) async {
    CustomServices.showLoading();
    await _dbRef.doc(id).update({'weightInKg': weight});
    CustomServices.dismissLoading();
  }

  static Future<QuerySnapshot> getAllItems() async {
    final response = await _dbRef.orderBy('date', descending: false).get();
    return response;
  }
}
