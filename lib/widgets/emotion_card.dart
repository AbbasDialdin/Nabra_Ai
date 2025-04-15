import 'package:flutter/material.dart';
import '../models/emotion_type.dart';

class EmotionCard extends StatelessWidget {
  final String label;
  final double confidence; // 0.0 إلى 1.0

  const EmotionCard({super.key, required this.label, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final emotion = EmotionTypes.getByName(label);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: emotion.color.withOpacity(0.2),
          child: Icon(emotion.icon, color: emotion.color),
        ),
        title: Text(
          'الشعور: ${emotion.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('الثقة: ${(confidence * 100).toStringAsFixed(1)}%'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
