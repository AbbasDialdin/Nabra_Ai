import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/input_provider.dart';
import '../providers/result_provider.dart';
import '../services/api_service.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _analyzeText();
  }

  void _analyzeText() async {
    final input = Provider.of<InputProvider>(context, listen: false).inputText;
    if (input != null && input.isNotEmpty) {
      final result = await ApiService.analyzeText(input);
      Provider.of<ResultProvider>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).setResult(result['sentiment'], result['confidence']);
    }
    setState(() => _loading = false);
  }

  String getArabicSentiment(String sentiment) {
    switch (sentiment) {
      case 'POSITIVE':
        return 'إيجابي';
      case 'NEGATIVE':
        return 'سلبي';
      case 'NEUTRAL':
      default:
        return 'محايد';
    }
  }

  String getEmoji(String sentiment) {
    switch (sentiment) {
      case 'POSITIVE':
        return '😄';
      case 'NEGATIVE':
        return '😞';
      case 'NEUTRAL':
      default:
        return '😐';
    }
  }

  @override
  Widget build(BuildContext context) {
    final input = Provider.of<InputProvider>(context);
    final result = Provider.of<ResultProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2979FF), Color(0xFF00FFB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child:
                _loading
                    ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'نتائج التحليل',
                          style: GoogleFonts.cairo(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'النص المُدخل:',
                          style: GoogleFonts.cairo(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          input.inputText ?? '',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            getEmoji(result.sentiment),
                            key: ValueKey<String>(result.sentiment),
                            style: const TextStyle(fontSize: 64),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          getArabicSentiment(result.sentiment),
                          style: GoogleFonts.cairo(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: result.confidence,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'درجة الثقة: ${(result.confidence * 100).toStringAsFixed(1)}%',
                          style: GoogleFonts.cairo(color: Colors.white),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.refresh),
                          label: const Text('تحليل جديد'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
