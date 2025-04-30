import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';

abstract class AttendanceRepo {
  Map<String, dynamic>? checkInMap;
  Map<String, dynamic>? checkOutMap;
  Future<Either<Failure, String>> checkAttendance(CheckType checkType);
  Future<Either<Failure, void>> fetchTodayAttendance();
}
