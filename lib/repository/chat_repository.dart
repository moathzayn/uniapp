import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniapp/enums/message_enum.dart';
import 'package:uniapp/models/chat_contact.dart';
import 'package:uniapp/models/message.dart';
import 'package:uniapp/uitls/utils.dart';
import 'package:uniapp/models/user.dart' as model;
import 'package:uuid/uuid.dart';

final chatRepositoryPorvider = Provider(
  (ref) => ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });
  void _saveDataToContactsSubcollection(
    model.User senderUserData,
    model.User recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContact(
      email: senderUserData.email,
      uid: senderUserData.uid,
      photoUrl: senderUserData.photoUrl,
      username: senderUserData.username,
      timeSent: timeSent,
      text: text,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    var senderChatContact = ChatContact(
      uid: recieverUserData.uid,
      email: recieverUserData.email,
      photoUrl: recieverUserData.photoUrl,
      username: recieverUserData.username,
      timeSent: timeSent,
      text: text,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveDataToMessageSubcollection({
    required String reciverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required recieverUsername,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: recieverUsername,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(reciverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );

    await firestore
        .collection('users')
        .doc(reciverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String reciverUserId,
    required model.User senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      model.User recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(reciverUserId).get();
      recieverUserData = model.User.formMap(userDataMap.data()!);

      var messageId = const Uuid().v4();
      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        reciverUserId,
      );

      _saveDataToMessageSubcollection(
          reciverUserId: reciverUserId,
          text: text,
          timeSent: timeSent,
          messageType: MessageEnum.text,
          messageId: messageId,
          username: senderUser.username,
          recieverUsername: recieverUserData.username);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
