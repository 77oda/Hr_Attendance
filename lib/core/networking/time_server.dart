import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:http/http.dart' as http;

class TimeServer {
  static Future<DateTime> fetchTime() async {
    try {
      const apiKey = '64ad8287c7234d2da4eeb1a469d41b4c'; // حط مفتاحك هنا
      final url = Uri.parse(
        'https://api.ipgeolocation.io/timezone?apiKey=$apiKey&tz=Africa/Cairo',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dateTimeStr = data['date_time'];
        return DateTime.parse(dateTimeStr);
      } else {
        throw Exception('فشل في جلب الوقت من السيرفر');
      }
    } on SocketException {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } on TimeoutException {
      throw Exception('انتهت مهلة الاتصال بالخادم');
    } catch (error) {
      throw Exception('حدث خطأ غير متوقع: ${error.toString()}');
    }
  }
}
