import 'package:dartz/dartz.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, String>> checkAttendance(CheckType checkType);
}
