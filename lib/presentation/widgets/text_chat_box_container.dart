import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import '../manager/chat_box_color_provider.dart';
import '../manager/chat_message_provider.dart';

class TextChatBoxContainer extends StatelessWidget {
  const TextChatBoxContainer({super.key, required this.chatMessageProvider, required this.messageIndex, required this.isUser, required this.message, required this.messageID});
  final ChatMessageProvider chatMessageProvider;
  final String message;
  final int messageIndex;
  final bool isUser;
  final String messageID;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Consumer<ChatBoxColorProvider>(
          builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(
                vertical: isUser ? 0 : 6,
                horizontal: isUser ? 12 : 0,
              ),
              constraints: BoxConstraints(
                maxWidth: 260,
              ),
              decoration: BoxDecoration(
                color:
                isUser
                    ? value.selectedChatBoxColor
                    : Colors.white,
                borderRadius:
                isUser
                    ? BorderRadius.only(
                  topLeft: Radius.circular(
                    10,
                  ),
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  bottomRight:
                  Radius.circular(10),
                )
                    : BorderRadius.only(
                  topRight: Radius.circular(
                    10,
                  ),
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  bottomRight:
                  Radius.circular(10),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color:
                  isUser
                      ? Colors.white
                      : Colors.black87,
                  fontSize: 15,
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            chatMessageProvider.changeDeletedState(
              messageIndex,
            );
            chatMessageProvider.deleteMessageFromFirebase(messageID);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
              vertical: isUser ? 0 : 6,
              horizontal: isUser ? 12 : 0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Delete Message",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Source Sans Pro",
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  "assets/icons/delete_icon.svg",
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
