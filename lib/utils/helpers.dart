import 'package:intl/intl.dart';

String formatDate(String isoString) {
  final date = DateTime.tryParse(isoString);
  if (date == null) return isoString;
  return DateFormat('yyyy/MM/dd – HH:mm').format(date);
}
