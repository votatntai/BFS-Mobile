import 'package:intl/intl.dart';

String myFormatTime(String timeString) {
  DateTime time = DateTime.parse('1970-01-01 $timeString');
  String formattedTime = DateFormat('HH:mm').format(time);
  return formattedTime; // Loại bỏ số phút nếu là 00
}