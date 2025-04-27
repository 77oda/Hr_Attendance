import 'dart:convert';
import 'package:intl/intl.dart'; // للتعامل مع الوقت بشكل مناسب
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_attendance/core/helpers/cacheHelper.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/data/repos/attendance_repo.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(this.attendanceRepo) : super(AttendanceInitial());
  final AttendanceRepo attendanceRepo;

  // دالة للتحقق من الحضور أو المغادرة
  Future<void> checkAttendance(CheckType checkType) async {
    emit(AttendanceLoading());
    final result = await attendanceRepo.checkAttendance(checkType);
    result.fold(
      (l) {
        if (!isClosed) emit(AttendanceError(l.errMessage));
      },
      (r) async {
        await fetchTodayAttendance();
        if (!isClosed) emit(AttendanceSuccess(r));
      },
    );
  }

  Map<String, dynamic>? checkInMap;
  Map<String, dynamic>? checkOutMap;
  Future<void> fetchTodayAttendance() async {
    await resetAttendance();
    String? checkInString = await CacheHelper.getData(key: 'checkIn');
    String? checkOutString = await CacheHelper.getData(key: 'checkOut');
    if (checkInString != null) checkInMap = jsonDecode(checkInString);
    if (checkOutString != null) checkOutMap = jsonDecode(checkOutString);
    if (!isClosed) emit(AttendanceFetched());
  }

  Future<void> resetAttendance() async {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);

    String? data = await CacheHelper.getData(key: 'checkIn');

    if (data != null) {
      Map<String, dynamic> dataMap = jsonDecode(data);
      String? savedDate = dataMap['date'];

      print(savedDate);
      print(today); // التاريخ اللي كنت مخزنه مع الحضور

      if (savedDate != today) {
        // اليوم اللي مخزن غير اليوم الحالي → امسح الداتا
        await CacheHelper.removeData('checkIn');
        await CacheHelper.removeData('checkOut');
        checkInMap = null;
        checkOutMap = null;
        if (!isClosed) emit(AttendanceReset());
      }
    }
  }
}
