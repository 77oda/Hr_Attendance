import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_attendance/core/networking/time_server.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_state.dart';

class FetchAttendanceCubit extends Cubit<FetchAttendanceState> {
  FetchAttendanceCubit(this.mainRepo) : super(FetchAttendanceInitial());
  final MainRepo mainRepo;
  List<AttendanceModel> _allData = [];

  Future<void> fetchAttandanceData() async {
    emit(FetchAttendanceLoading());

    final result = await mainRepo.fetchAttendanceData();
    result.fold((l) => emit(FetchAttendanceError(l.errMessage)), (r) async {
      _allData = r;
      try {
        final currentTime = await TimeServer.fetchTime();
        filterByMonth(currentTime);
      } catch (e) {
        emit(FetchAttendanceError(e.toString())); // ترجع للمستخدم الخطأ
      }
    });
  }

  void filterByMonth(DateTime selectedDate) {
    emit(FetchAttendanceLoading());
    final filtered =
        _allData.where((e) {
          final date = DateTime.parse(
            e.date!,
          ); // لازم يكون e.date عبارة عن String صالح
          return date.year == selectedDate.year &&
              date.month == selectedDate.month;
        }).toList();

    emit(FetchAttendanceLoaded(filtered));
  }
}
