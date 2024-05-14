import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService extends ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  singInAndStoreData(
      {
        required String name,required String email, required String number, required String uid, required proPicPath
      }) async {
    try {
      await FirebaseMessaging.instance.getToken().then((token) {
        _fireStore.collection("datingUser").doc(uid).set({
          "uid": uid,
          "name": name,
          "email": email,
          "number": number,
          "token": "$token",
          "isOnline": false,
          "pro_pic": proPicPath
        });
      });
    } catch (e) {
      print("+++++++ FirebaseAuthException +++++ $e");
    }
  }

  singUpAndStore({
    required String name,required String email, required String number, required String uid, required proPicPath
  }) async {
    try {
      await FirebaseMessaging.instance.getToken().then((token) {
        _fireStore.collection("datingUser").doc(uid).set({
          "uid": uid,
          "name": name,
          "email": email,
          "number": number,
          "token": "$token",
          "isOnline": false,
          "pro_pic": proPicPath
        }, SetOptions(merge: true));
      });
    } catch (e) {
      print("+++++++ FirebaseAuthException +++++ $e");
    }
  }
}