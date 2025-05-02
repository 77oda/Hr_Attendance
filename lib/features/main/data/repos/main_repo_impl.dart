import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/core/theming/constants.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';
import 'package:hr_attendance/features/main/data/model/empoloyee.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo.dart';
import 'package:http/http.dart' as http;

class MainRepoImpl extends MainRepo {
  @override
  Future<Either<Failure, EmployeeModel>> fetchEmployee() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(phoneNumber)
              .get();

      if (doc.exists) {
        return Right(EmployeeModel.fromJson(doc.data()!));
      } else {
        return left(ServerFailure('الموظف غير موجود'));
      }
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceModel>>> fetchAttendanceData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(phoneNumber)
              .collection('attendance')
              .get();

      final List<AttendanceModel> attendanceList =
          snapshot.docs.map((doc) {
            return AttendanceModel(
              date: doc.id, // استخدام ID الوثيقة كـ "تاريخ اليوم"
              status:
                  doc['status'] ??
                  'غياب', // حالة الحضور (حضور، غياب، إجازة، ...).
              checkIn: doc['checkIn'] ?? '',
              checkOut: doc['checkOut'] ?? '',
            );
          }).toList();

      return right(attendanceList);
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime>> fetchTime() async {
    try {
      const apiKey = '64ad8287c7234d2da4eeb1a469d41b4c'; // حط مفتاحك هنا
      final url = Uri.parse(
        'https://api.ipgeolocation.io/timezone?apiKey=$apiKey&tz=Africa/Cairo',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dateTimeStr = data['date_time'];
        return right(DateTime.parse(dateTimeStr));
      } else {
        throw Exception('فشل في جلب الوقت من السيرفر');
      }
    } on SocketException catch (error) {
      // إذا حصل خطأ في الاتصال بالشبكة
      return left(ServerFailure('خطأ في الاتصال بالشبكة'));
    } on TimeoutException catch (error) {
      // في حالة المهلة انتهت
      return left(ServerFailure('انتهت المهلة، حاول مرة أخرى'));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
