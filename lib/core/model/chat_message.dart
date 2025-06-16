class ChatMessage {
  String id;
  final String text;
  final DateTime time;
  final bool isTyping;
  final String sender;
  bool isDeleted;
  bool isDeleting;
  bool isImage;
  bool isAudio;
  String? filePath;
  String? audioPath;

  ChatMessage({
    this.id="",
    required this.sender,
    required this.text,
    required this.time,
    this.isTyping = false,
    this.isDeleted = false,
    this.isImage = false,
    this.isAudio = false,
    this.isDeleting = false,
    this.filePath,
    this.audioPath,
  });
}
