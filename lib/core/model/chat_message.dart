class ChatMessage {
  // final int id;
  final String text;
  final DateTime time;
  final bool isTyping;
  final String receiver;
  bool isDeleted;
  bool isDeleting;

  ChatMessage({
    // required this.id,
    required this.receiver,
    required this.text,
    required this.time,
    this.isTyping = false,
    this.isDeleted = false,
    this.isDeleting = false,
  });
}