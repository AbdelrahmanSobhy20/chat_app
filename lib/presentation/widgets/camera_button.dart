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
