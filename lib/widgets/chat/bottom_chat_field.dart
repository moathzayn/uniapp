import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uniapp/uitls/colors.dart';

class bottomChatField extends StatefulWidget {
  const bottomChatField({super.key});

  @override
  State<bottomChatField> createState() => _bottomChatFieldState();
}

class _bottomChatFieldState extends State<bottomChatField> {
  bool isShowSendButton = false;

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
                    ? CircleAvatar(
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
                  borderRadius: BorderRadius.circular(30.0),
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
