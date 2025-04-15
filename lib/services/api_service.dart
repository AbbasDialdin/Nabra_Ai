// api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://nabra-backend.onrender.com'; // تأكد من رابطك الصحيح

  static Future<Map<String, dynamic>> analyzeText(String text) async {
    final url = Uri.parse('$baseUrl/analyze-text');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to analyze text');
    }
  }

  static Future<List<String>> analyzeGroupImage(File image) async {
    final url = Uri.parse('$baseUrl/analyze-image');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['emotion'] is String) {
        return [data['emotion']];
      } else if (data['emotion'] is List) {
        return List<String>.from(data['emotion']);
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to analyze image');
    }
  }
}
