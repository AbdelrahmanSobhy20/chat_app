import 'package:flutter/material.dart';

class BackgroundColorProvider extends ChangeNotifier {
  String selectedBackground = 'assets/images/background.jpg';
  final List backgrounds = [
    'assets/images/background2.jpg',
    'assets/images/background.jpg',
    'assets/images/background.jpg',
    'assets/images/background2.jpg',
    'assets/images/background2.jpg',
    'assets/images/background.jpg'
  ];
  changeBackgroundColor(String newBackgroundColor) {
    selectedBackground = newBackgroundColor;
    notifyListeners();
  }
}