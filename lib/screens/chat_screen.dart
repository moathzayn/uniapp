import 'package:flutter/material.dart';
import 'package:uniapp/widgets/chat/bottom_chat_field.dart';

class chatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: bottomChatField(),
      ),
    );
  }
}
