import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import '../manager/chat_message_provider.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key, required this.sender});
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageProvider>(
      builder: (context, chatMessageProvider, child) {
        return GestureDetector(
          onTap: () => chatMessageProvider.takePhoto(sender),
          child: SvgPicture.asset(
            'assets/icons/camera_icon.svg',
          ),
        );
      },
    );
  }
}


// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:svg_flutter/svg.dart';
//
// import '../../core/model/chat_message.dart';
// import '../manager/chat_message_provider.dart';
//
// class CameraButton extends StatelessWidget {
//   const CameraButton({super.key, required this.sender});
//   final String sender;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatMessageProvider>(
//       builder: (context, chatMessageProvider, child) {
//         return GestureDetector(
//           // onTap: () => chatMessageProvider.takePhoto(sender),
//           onTap: () async {
//             final picker = ImagePicker();
//             final pickedImage = await picker.pickImage(source: ImageSource.camera);
//             if (pickedImage == null) return;
//
//             final imageFile = File(pickedImage.path);
//
//             final storageRef = FirebaseStorage.instance
//                 .ref()
//                 .child('chat_images')
//                 .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//
//             await storageRef.putFile(imageFile);
//
//             final imageUrl = await storageRef.getDownloadURL();
//
//             final chatProvider =
//             Provider.of<ChatMessageProvider>(context, listen: false);
//
//             final newMessage = ChatMessage(
//               text: '',
//               time: DateTime.now(),
//               isImage: true,
//               isAudio: false,
//               filePath: imageUrl,
//               sender: sender,
//             );
//
//             chatProvider.addMessage(newMessage);
//           },
//
//           child: SvgPicture.asset(
//             'assets/icons/camera_icon.svg',
//           ),
//         );
//       },
//     );
//   }
// }
