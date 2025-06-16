import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/model/chat_message.dart';

class ChatMessageProvider extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];
  int currentIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  late String audioPath = '';
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  final audioRecorder = AudioRecorder();

  Future<void> takePhoto(String sender) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final file = File(photo.path);
      final newMessage = ChatMessage(
        text: "",
        time: DateTime.now(),
        isImage: true,
        filePath: file.path,
        isDeleted: false,
        isDeleting: false,
        sender: sender,
      );
      addMessage(newMessage);
    }
  }

  Future<String> _getAudioFilePath() async {
    final dir = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
    final recordingsDir = Directory('${dir.path}/recordings');
    if (!await recordingsDir.exists()) {
      await recordingsDir.create(recursive: true);
    }
    return '${recordingsDir.path}/myFile_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<void> startRecording(String sender) async {
    try {
      if (await audioRecorder.hasPermission()) {
        final path = await _getAudioFilePath();
        await audioRecorder.start(const RecordConfig(), path: path);
        audioPath = path;
        _isRecording = true;
        notifyListeners();
      } else {
        print("Microphone permission denied");
      }
    } catch (e) {
      print("Error while starting recording: $e");
    }
  }

  Future<void> stopRecording({required String sender}) async {
    try {
      if (_isRecording) {
        final path = await audioRecorder.stop();
        if (path != null && await File(path).exists()) {
          print("File exists at: $path");
          audioPath = path;
          final newMessage = ChatMessage(
            text: "",
            time: DateTime.now(),
            isImage: false,
            isAudio: true,
            filePath: path,
            isDeleted: false,
            isDeleting: false,
            sender: sender,
          );
          addMessage(newMessage);
        } else {
          print("File does not exist at: $path");
        }
      }
    } catch (e) {
      print("Error while stopping recording: $e");
    }
    _isRecording = false;
    notifyListeners();
  }
  Future<void> deleteAllMessages() async {
    try {
      final snapshot = await firestore.collection('messages').get();

      for (var doc in snapshot.docs) {
        await firestore.collection('messages').doc(doc.id).delete();
      }

      chatMessages.clear();
      notifyListeners();
      print("All messages deleted successfully.");
    } catch (e) {
      print("Error deleting all messages: $e");
    }
  }


  void addMessage(ChatMessage message) async {
    final docRef = await firestore.collection('messages').add({
      'text': message.text,
      'timestamp': message.time,
      'isImage': message.isImage,
      'isAudio': message.isAudio,
      'filePath': message.filePath,
      'audioPath': message.audioPath,
      'isDeleted': message.isDeleted,
      'sender': message.sender,
    });
    message.id = docRef.id;
    chatMessages[chatMessages.length - 1] = message;
    notifyListeners();
  }

  void toggleDeletingState(int index) {
    if (!chatMessages[index].isDeleted) {
      chatMessages[index].isDeleting = !chatMessages[index].isDeleting;
    }
    notifyListeners();
  }

  void changeDeletedState(int index) async {
    final id = chatMessages[index].id;
    chatMessages[index].isDeleted = true;
    chatMessages[index].isDeleting = false;
    notifyListeners();
    await deleteMessageFromFirebase(id);
  }

  Future<void> deleteMessageFromFirebase(String id) async {
    try {
      await firestore.collection('messages').doc(id).update({
        'text': '',
        'isDeleted': true,
      });
      print("Message updated");
    } catch (e) {
      print("Error updating message: $e");
    }
    notifyListeners();
  }

  void getMessages() {
    firestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      chatMessages = snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatMessage(
          id: doc.id,
          text: data['text'] ?? '',
          time: (data['timestamp'] as Timestamp).toDate(),
          isImage: data['isImage'] ?? false,
          isAudio: data['isAudio'] ?? false,
          filePath: data['filePath'] ?? '',
          audioPath: data['audioPath'] ?? '',
          isDeleted: data['isDeleted'] ?? false,
          isDeleting: false,
          sender: data['sender'] ?? '',
        );
      }).toList();
      notifyListeners();
    });
  }
}
