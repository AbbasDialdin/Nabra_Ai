class AnalysisModel {
  final int? id;
  final String type; // 'text', 'image', 'group'
  final String input; // نص التحليل أو مسار الصورة
  final String result; // الشعور (happy, sad, etc.)
  final String datetime; // بصيغة ISO

  AnalysisModel({
    this.id,
    required this.type,
    required this.input,
    required this.result,
    required this.datetime,
  });

  /// تحويل من Map (SQLite) إلى Object
  factory AnalysisModel.fromMap(Map<String, dynamic> map) {
    return AnalysisModel(
      id: map['id'],
      type: map['type'],
      input: map['input'],
      result: map['result'],
      datetime: map['datetime'],
    );
  }

  /// تحويل إلى Map (للإدخال في SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'input': input,
      'result': result,
      'datetime': datetime,
    };
  }
}
