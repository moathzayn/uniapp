import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniapp/models/message.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class ChatMethods extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(String receiverUid, String message) async {
    final String currentUserUid = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
      senderId: currentUserUid,
      recieverid: receiverUid,
      text: message,
      timeSent: timestamp,
      messageId: const Uuid().v4(),
    );
    List<String> ids = [currentUserUid, receiverUid];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeSent', descending: false)
        .snapshots();
  }
}
