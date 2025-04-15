import 'package:flutter/material.dart';

class EmotionType {
  final String name;
  final Color color;
  final IconData icon;

  const EmotionType({
    required this.name,
    required this.color,
    required this.icon,
  });
}

class EmotionTypes {
  static const List<EmotionType> all = [
    EmotionType(
      name: 'happy',
      color: Colors.green,
      icon: Icons.sentiment_satisfied_alt,
    ),
    EmotionType(
      name: 'sad',
      color: Colors.blueGrey,
      icon: Icons.sentiment_dissatisfied,
    ),
    EmotionType(
      name: 'angry',
      color: Colors.redAccent,
      icon: Icons.sentiment_very_dissatisfied,
    ),
    EmotionType(
      name: 'fear',
      color: Colors.deepPurple,
      icon: Icons.warning_amber_rounded,
    ),
    EmotionType(name: 'surprise', color: Colors.orange, icon: Icons.lightbulb),
    EmotionType(
      name: 'neutral',
      color: Colors.grey,
      icon: Icons.sentiment_neutral,
    ),
    EmotionType(
      name: 'positive',
      color: Colors.greenAccent,
      icon: Icons.thumb_up_alt,
    ),
    EmotionType(
      name: 'negative',
      color: Colors.red,
      icon: Icons.thumb_down_alt,
    ),
  ];

  /// Get by name
  static EmotionType getByName(String name) {
    return all.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse:
          () => EmotionType(
            name: name,
            color: Colors.teal,
            icon: Icons.help_outline,
          ),
    );
  }
}
