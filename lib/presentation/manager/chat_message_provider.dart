import 'package:flutter/material.dart';

import '../../core/model/chat_message.dart';

class ChatMessageProvider extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];
  int currentIndex = 0;

  void addMessage(ChatMessage chatMessage) {
    chatMessages.add(chatMessage);
    currentIndex = chatMessages.length;
    notifyListeners();
  }

  void toggleDeletingState(int index) {
    if (chatMessages[index].isDeleted != true) {
      chatMessages[index].isDeleting = !chatMessages[index].isDeleting;
    } else {
      null;
    }
    notifyListeners();
  }

  void changeDeletedState(int index) {
    chatMessages[index].isDeleted = true;
    chatMessages[index].isDeleting = false;
    notifyListeners();
  }
}
