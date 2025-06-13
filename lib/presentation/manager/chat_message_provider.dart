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
        audioPath = path; // تحديث المسار
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
  void addMessage(ChatMessage chatMessage) {
    chatMessages.add(chatMessage);
    currentIndex = chatMessages.length;
    notifyListeners();
  }

  void toggleDeletingState(int index) {
    if (!chatMessages[index].isDeleted) {
      chatMessages[index].isDeleting = !chatMessages[index].isDeleting;
    }
    notifyListeners();
  }

  void changeDeletedState(int index) {
    chatMessages[index].isDeleted = true;
    chatMessages[index].isDeleting = false;
    notifyListeners();
  }

  void getMessages() async {
    await for (var snapshot in firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
}