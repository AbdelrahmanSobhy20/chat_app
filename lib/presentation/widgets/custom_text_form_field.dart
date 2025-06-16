import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/model/chat_message.dart';
import '../manager/chat_message_provider.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.controller, required this.sender});
  final TextEditingController controller;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal:
          MediaQuery.of(context).size.width * 0.03,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child:
        Consumer<ChatMessageProvider>(
            builder: (context, chatMessageProvider, child) {
              return TextField(
                controller: controller,
                onSubmitted: (value) {
                  if (value.trim().isEmpty) return;

                  final chatProvider =
                  Provider.of<ChatMessageProvider>(context, listen: false);

                  final newMessage = ChatMessage(
                    text: value,
                    time: DateTime.now(),
                    isImage: false,
                    isAudio: false,
                    sender: sender,
                  );

                  chatProvider.addMessage(newMessage);

                  controller.clear();
                },

                // onEditingComplete: () {
                //   chatMessageProvider.addMessage(
                //     ChatMessage(
                //       text: controller.text,
                //       time: DateTime.now(),
                //       sender: sender,
                //     ),
                //   );
                //   chatMessageProvider.firestore.collection('messages').add({
                //     'text': controller.text,
                //     'time': DateTime.now(),
                //     'sender': sender,
                //   });
                //   controller.clear();
                // },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "write something...",
                  hintStyle: TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              );
            }),

      ),
    );
  }
}
