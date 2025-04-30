import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/helpers/cacheHelper.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/core/theming/constants.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/data/repos/attendance_repo.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // للتعامل مع الوقت بشكل مناسب

class AttendanceRepoImpl extends AttendanceRepo {
  @override
  Future<Either<Failure, String>> checkAttendance(CheckType type) async {
    try {
      final dateTime = await fetchTime();
      final date = DateFormat('yyyy-MM-dd').format(dateTime);
      final time = DateFormat('hh:mm a').format(dateTime);

      final snapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(phoneNumber)
              .collection('attendance')
              .doc(date)
              .get();
      if (!_isWeekend(dateTime)) {
        if (type == CheckType.checkIn) {
          if (snapshot.exists) {
            return left(ServerFailure('تم تسجيل الحضور بالفعل'));
          } else {
            await registerCheckIn(date: date, time: time).then((snapshot) {});
            Map<String, dynamic> data = {'time': time, 'date': date};
            CacheHelper.setData(key: 'checkIn', value: jsonEncode(data));
            return right('تم تسجيل الحضور بنجاح');
          }
        }

        if (type == CheckType.checkOut) {
          if (snapshot.exists) {
            if (snapshot.data()!['checkOut'] == null) {
              await registerCheckOut(date: date, time: time);
              Map<String, dynamic> data = {'time': time, 'date': date};
              CacheHelper.setData(key: 'checkOut', value: jsonEncode(data));
              return right('تم تسجيل الانصراف بنجاح ');
            } else {
              return left(ServerFailure('تم تسجيل الانصراف بالفعل'));
            }
          } else {
            return left(
              ServerFailure(
                'لم يتم تسجيل الحضور اليوم مسبقا\n لذلك لا يمكن تسجيل الانصراف',
              ),
            );
          }
        }
        return left(ServerFailure('حدث خطأ'));
      } else {
        return left(ServerFailure('لا يمكن التسجيل في الوقت الحالي'));
      }
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
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

  Future<DateTime> fetchTime() async {
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
  }

  bool _isWeekend(DateTime dateTime) {
    final currentDay = dateTime.weekday;
    return currentDay == DateTime.friday || currentDay == DateTime.saturday;
  }

  Future<void> registerCheckIn({required date, required time}) async {
    AttendanceModel attendanceModel = AttendanceModel(
      status: 'حضور',
      checkIn: time,
      checkOut: null,
      date: date,
    );
    await FirebaseFirestore.instance
        .collection('employees')
        .doc(phoneNumber)
        .collection('attendance')
        .doc(date)
        .set(attendanceModel.toJson());
  }

  Future<void> registerCheckOut({required time, required date}) async {
    await FirebaseFirestore.instance
        .collection('employees')
        .doc(phoneNumber)
        .collection('attendance')
        .doc(date)
        .update({'checkOut': time});
  }

  @override
  Map<String, dynamic>? checkInMap;
  @override
  Map<String, dynamic>? checkOutMap;

  @override
  Future<Either<Failure, void>> fetchTodayAttendance() async {
    try {
      await resetAttendance();
      String? checkInString = await CacheHelper.getData(key: 'checkIn');
      String? checkOutString = await CacheHelper.getData(key: 'checkOut');
      if (checkInString != null) checkInMap = jsonDecode(checkInString);
      if (checkOutString != null) checkOutMap = jsonDecode(checkOutString);
      return right(null);
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

  Future<void> resetAttendance() async {
    final dateTime = await fetchTime();
    final today = DateFormat('yyyy-MM-dd').format(dateTime);
    String? data = await CacheHelper.getData(key: 'checkIn');

    if (data != null) {
      Map<String, dynamic> dataMap = jsonDecode(data);
      String? savedDate = dataMap['date'];

      if (savedDate != today) {
        // اليوم اللي مخزن غير اليوم الحالي → امسح الداتا
        await CacheHelper.removeData('checkIn');
        await CacheHelper.removeData('checkOut');
        checkInMap = null;
        checkOutMap = null;
      }
    }
  }
}
