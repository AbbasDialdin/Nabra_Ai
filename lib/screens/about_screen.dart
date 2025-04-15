import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // هذه لإجبار الاتجاه RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عن التطبيق',
                    style: GoogleFonts.cairo(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'تطبيق "نبرة – Nabra"',
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'نبرة هو تطبيق ذكي لتحليل مشاعر المستخدمين باستخدام الذكاء الاصطناعي. يعتمد بشكل رئيسي على تحليل النصوص باللغة العربية والإنجليزية مع واجهة بسيطة وسهلة الاستخدام، ويعمل بشكل محلي للحفاظ على الخصوصية والسرعة.',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'الإصدار: 1.0.0',
                    style: GoogleFonts.cairo(fontSize: 16, color: Colors.white),
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      '© 2025 نبرة - جميع الحقوق محفوظة',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                    ),
                    child: const Text('رجوع'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
