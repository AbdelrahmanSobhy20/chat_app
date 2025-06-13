import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/const.dart';
import '../manager/chat_box_color_provider.dart';
import '../manager/chat_message_provider.dart';

class AudioChatBoxContainer extends StatelessWidget {
  const AudioChatBoxContainer({
    super.key,
    required this.chatMessageProvider,
    required this.messageIndex,
    required this.isUser,
  });

  final ChatMessageProvider chatMessageProvider;
  final int messageIndex;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final filePath =
              chatMessageProvider.chatMessages[messageIndex].filePath;
          if (filePath != null) {
            final file = File(filePath);
            if (await file.exists()) {
              print("Attempting to play file at: $filePath");
              await audioPlayer.play(DeviceFileSource(filePath));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Audio file not found at: $filePath')),
              );
            }
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Consumer<ChatBoxColorProvider>(
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(
                vertical: isUser ? 0 : 6,
                horizontal: isUser ? 12 : 0,
              ),
              constraints: BoxConstraints(maxWidth: 260),
              decoration: BoxDecoration(
                color: isUser ? value.selectedChatBoxColor : Colors.white,
                borderRadius:
                    isUser
                        ? BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                        : BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.black87),
                  SizedBox(width: 8),
                  Text(
                    "Voice Message",
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
