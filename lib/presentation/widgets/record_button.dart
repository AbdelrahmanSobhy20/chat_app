import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import '../manager/chat_message_provider.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key, required this.sender});
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageProvider>(
      builder: (context, chatMessageProvider, child) {
        final iconColor =
        chatMessageProvider.isRecording
            ? Colors.red
            : Colors.white;
        return GestureDetector(
          onTap: () {
            if (chatMessageProvider.isRecording) {
              chatMessageProvider.stopRecording(
                sender: sender,
              );
            } else {
              chatMessageProvider.startRecording(sender);
            }
          },
          child: SvgPicture.asset(
            'assets/icons/record_icon.svg',
            color: iconColor,
          ),
        );
      },
    );
  }
}
