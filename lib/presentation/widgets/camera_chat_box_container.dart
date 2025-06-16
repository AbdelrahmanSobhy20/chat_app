import 'dart:io';

import 'package:flutter/material.dart';

import '../manager/chat_message_provider.dart';

class CameraChatBoxContainer extends StatelessWidget {
  const CameraChatBoxContainer({
    super.key,
    required this.chatMessageProvider,
    required this.messageIndex,
  });

  final ChatMessageProvider chatMessageProvider;
  final int messageIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        chatMessageProvider.toggleDeletingState(messageIndex);
      },
      onTapUp: (details) {
        chatMessageProvider.toggleDeletingState(messageIndex);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Image.file(
          File(chatMessageProvider.chatMessages[messageIndex].filePath!),
          fit: BoxFit.cover,
          width: 250,
          height: 250,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/tmp_image.png',
              fit: BoxFit.cover,
              width: 250,
              height: 250,
            );
          },
        ),
      ),
    );
  }
}
