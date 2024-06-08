import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniapp/controller/chat_controller.dart';
import 'package:uniapp/repository/chat_repository.dart';
import 'package:uniapp/uitls/colors.dart';

final chatcontrollerProvider = Provider((ref) {
  final ChatRepository = ref.watch(chatRepositoryPorvider);
  return ChatController(
    chatRepository: ChatRepository,
    ref: ref,
  );
});

// ignore: camel_case_types
class bottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const bottomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<bottomChatField> createState() => _bottomChatFieldState();
}

// ignore: camel_case_types
class _bottomChatFieldState extends ConsumerState<bottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  @override
  // ignore: must_call_super
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatcontrollerProvider).sendTextMessage(
          context, _messageController.text.trim(), widget.recieverUserId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              if (val.isNotEmpty) {
                setState(() {
                  isShowSendButton = true;
                });
              } else {
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: primaryColor,
                prefixIcon: isShowSendButton
                    ? const SizedBox()
                    : const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                suffixIcon: isShowSendButton
                    ? const CircleAvatar(
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                hintText: 'Type a message!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(5)),
          ),
        ),
      ],
    );
  }
}
