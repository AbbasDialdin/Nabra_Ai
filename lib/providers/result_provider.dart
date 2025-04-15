import 'package:flutter/material.dart';

class ResultProvider with ChangeNotifier {
  String sentiment = '';
  double confidence = 0.0;

  void setResult(String newSentiment, double newConfidence) {
    sentiment = newSentiment;
    confidence = newConfidence;
    notifyListeners();
  }

  void clear() {
    sentiment = '';
    confidence = 0.0;
    notifyListeners();
  }
}
