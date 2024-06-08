import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/repository/chat_repository.dart';
import 'package:uniapp/resources/auth_methods.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataAuthProvider = Provider(
  (ref) => ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
      BuildContext context, String text, String reciverUserId) {
    ref.read(userDataAuthProvider as ProviderListenable).whenData(
          (value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              reciverUserId: reciverUserId,
              senderUser: value!),
        );
  }
}
