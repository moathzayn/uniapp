import 'package:flutter/material.dart';
import 'package:uniapp/widgets/chat/bottom_chat_field.dart';

class feedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Icon(Icons.send)]),
      body: Center(
        child: bottomChatField(),
      ),
    );
  }
}
