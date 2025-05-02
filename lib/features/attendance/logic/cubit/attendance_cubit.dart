import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/data/repos/attendance_repo.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_state.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_cubit.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(this.attendanceRepo, this.fetchAttendanceCubit)
    : super(AttendanceInitial());
  final AttendanceRepo attendanceRepo;
  final FetchAttendanceCubit fetchAttendanceCubit;
  Map<String, dynamic>? checkInMap;
  Map<String, dynamic>? checkOutMap;

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
        await fetchAttendanceCubit.fetchAttandanceData();
        if (!isClosed) emit(AttendanceSuccess(r));
      },
    );
  }

  Future<void> fetchTodayAttendance() async {
    await attendanceRepo.fetchTodayAttendance();
    checkInMap = attendanceRepo.checkInMap;
    checkOutMap = attendanceRepo.checkOutMap;
    if (!isClosed) emit(AttendanceFetched());
  }
}
