import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class ChatBoxColorProvider extends ChangeNotifier {
  final List chatBoxColors = [
    AppColors.blueColor,
    AppColors.pinkColor,
    AppColors.orangeColor,
    AppColors.yellowColor,
    AppColors.greenColor,
    AppColors.cyanColor,
  ];
  Color selectedChatBoxColor = AppColors.blueColor;

  void changeChatBoxColor(Color newChatBoxColor) {
    selectedChatBoxColor = newChatBoxColor;
    notifyListeners();
  }
}