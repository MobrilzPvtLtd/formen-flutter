import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../language/localization/app_localization.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Future<void> sendMessage({required String receiverId, required String messeage,required context}) async {
    try{
      final String currentUserId = Provider.of<HomeProvider>(context,listen: false).uid;
      final String currentUserName = Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name ?? "";

      Timestamp timestamp = Timestamp.now();

      Message newMessage = Message(
          senderId: currentUserId,
          senderName: currentUserName,
          reciverId: receiverId,
          message: messeage,
          timestamp: timestamp);

      List<String> ids = [currentUserId, receiverId];
      ids.sort();

      String chatRoomId = ids.join("_");

      await _firebaseStorage.collection("chat_rooms").doc(chatRoomId).collection("message").add(newMessage.toMap());
    }catch(e){
      // Fluttertoast.showToast(msg: "Something Want Wrong".tr);
      Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Something Want Wrong") ?? "Something Want Wrong");
    }

  }

  Stream<QuerySnapshot> getMessage({required String userId, required String otherUserId}) {
    List ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firebaseStorage
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}


class Message {
  final String senderId;
  final String senderName;
  final String reciverId;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderId,
        required this.senderName,
        required this.reciverId,
        required this.message,
        required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderid': senderId,
      'senderName': senderName,
      'reciverId': reciverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}

