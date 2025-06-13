import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/presentation/manager/chat_box_color_provider.dart';
import 'package:chat_app/presentation/manager/chat_message_provider.dart';
import 'package:chat_app/presentation/widgets/text_chat_box_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../core/model/chat_message.dart';
import '../../core/utils/app_colors.dart';
import 'audio_chat_box_container.dart';
import 'camera_chat_box_container.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage message;
  final String sender;
  final bool isUser;
  final int messageIndex;

  const ChatBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.isUser,
    required this.messageIndex,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('hh:mm a').format(widget.message.time);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!widget.isUser)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                widget.sender == "Maria"
                    ? "assets/images/person.png"
                    : "assets/images/person2.jpg",
              ),
              radius: 16,
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isUser
                ? Text("")
                : Text(
                  widget.sender,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Source Sans Pro",
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
            Consumer<ChatMessageProvider>(
              builder: (context, chatMessageProvider, child) {
                return chatMessageProvider
                        .chatMessages[widget.messageIndex]
                        .isAudio
                    ? AudioChatBoxContainer(
                      messageIndex: widget.messageIndex,
                      isUser: widget.isUser,
                      chatMessageProvider: chatMessageProvider,
                    )
                    : chatMessageProvider
                        .chatMessages[widget.messageIndex]
                        .isImage
                    ? CameraChatBoxContainer(
                      messageIndex: widget.messageIndex,
                      chatMessageProvider: chatMessageProvider,
                    )
                    : GestureDetector(
                      onLongPress: () {
                        chatMessageProvider.toggleDeletingState(
                          widget.messageIndex,
                        );
                      },
                      onTapUp: (details) {
                        chatMessageProvider.toggleDeletingState(
                          widget.messageIndex,
                        );
                      },
                      child:
                          widget.isUser &&
                                  chatMessageProvider
                                      .chatMessages[widget.messageIndex]
                                      .isDeleting
                              ? TextChatBoxContainer(
                                messageIndex: widget.messageIndex,
                                isUser: widget.isUser,
                                chatMessageProvider: chatMessageProvider,
                                message: widget.message.text,
                              )
                              : chatMessageProvider
                                  .chatMessages[widget.messageIndex]
                                  .isDeleted
                              ? Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12,
                                ),
                                constraints: BoxConstraints(maxWidth: 260),
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreyColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/deleted_message_icon.svg",
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "You deleted this message",
                                      style: TextStyle(
                                        color:
                                            widget.isUser
                                                ? Colors.white
                                                : Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Consumer<ChatBoxColorProvider>(
                                builder: (context, value, child) {
                                  return Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.symmetric(
                                      vertical: widget.isUser ? 0 : 6,
                                      horizontal: widget.isUser ? 12 : 0,
                                    ),
                                    constraints: BoxConstraints(maxWidth: 260),
                                    decoration: BoxDecoration(
                                      color:
                                          widget.isUser
                                              ? value.selectedChatBoxColor
                                              : Colors.white,
                                      borderRadius:
                                          widget.isUser
                                              ? BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                  10,
                                                ),
                                              )
                                              : BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                  10,
                                                ),
                                              ),
                                    ),
                                    child: Text(
                                      widget.message.text,
                                      style: TextStyle(
                                        color:
                                            widget.isUser
                                                ? Colors.white
                                                : Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                },
                              ),
                    );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Source Sans Pro",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
