import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/data/repos/attendance_repo.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_state.dart';
import 'package:http/http.dart' as http;

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
      (r) {
        if (!isClosed) emit(AttendanceSuccess(r));
      },
    );
  }

  // دالة لتسجيل الحضور
  // Future<void> registerCheckIn(String employeeId) async {
  //  emit(CheckInLoading());
  //  final result = await attendanceRepo.registerCheckIn();
  //    result.fold((l) {
  //      if (!isClosed)  emit(CheckOutError(l.errMessage));
  //      }, (r) {
  //    if (!isClosed)   emit(CheckInSuccess());
  //   });
  // }

  // // دالة لتسجيل المغادرة
  // Future<void> registerCheckOut(String employeeId) async {
  //   emit(CheckOutLoading());
  //  final result = await attendanceRepo.registerCheckOut();
  //    result.fold((l) {
  //      if (!isClosed)  emit(CheckOutError(l.errMessage));
  //      }, (r) {
  //    if (!isClosed)   emit(CheckOutSuccess());
  //   });
  // }
}
