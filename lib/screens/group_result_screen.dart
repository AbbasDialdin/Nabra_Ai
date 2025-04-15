// ignore: unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/input_provider.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class GroupResultScreen extends StatefulWidget {
  const GroupResultScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GroupResultScreenState createState() => _GroupResultScreenState();
}

class _GroupResultScreenState extends State<GroupResultScreen> {
  bool _loading = true;
  List<String> emotions = [];

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    final imageFile =
        Provider.of<InputProvider>(context, listen: false).imageFile;

    if (imageFile != null) {
      try {
        final result = await ApiService.analyzeGroupImage(imageFile);
        if (!mounted) return;

        setState(() {
          emotions = result;
          _loading = false;
        });

        // حفظ النتيجة في قاعدة البيانات
        await DatabaseHelper.insertAnalysis(
          type: 'group',
          input: imageFile.path,
          result: result.join(', '),
          datetime: DateTime.now().toIso8601String(),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تحليل الصورة. حاول مرة أخرى')),
        );
      }
    }
  }

  Map<String, int> getEmotionCounts() {
    final counts = <String, int>{};
    for (var emo in emotions) {
      counts[emo] = (counts[emo] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = Provider.of<InputProvider>(context).imageFile;

    return Scaffold(
      appBar: AppBar(title: const Text('تحليل جماعي')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'عدد الأشخاص المُكتشفين: ${emotions.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    if (imageFile != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(imageFile, height: 180),
                      ),
                    const Divider(height: 32),
                    Expanded(
                      child:
                          emotions.isEmpty
                              ? const Center(
                                child: Text('لم يتم الكشف عن مشاعر.'),
                              )
                              : ListView.builder(
                                itemCount: emotions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text('#${index + 1}'),
                                    ),
                                    title: Text('الشعور: ${emotions[index]}'),
                                  );
                                },
                              ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.refresh),
                      label: const Text('تحليل جديد'),
                    ),
                  ],
                ),
              ),
    );
  }
}
