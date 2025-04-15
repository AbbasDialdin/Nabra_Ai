import 'dart:io';
import 'package:flutter/material.dart';

class InputProvider with ChangeNotifier {
  String? inputText;
  File? imageFile;

  void setText(String text) {
    inputText = text;
    notifyListeners();
  }

  void setImage(File image) {
    imageFile = image;
    notifyListeners();
  }

  void clear() {
    inputText = null;
    imageFile = null;
    notifyListeners();
  }
}
