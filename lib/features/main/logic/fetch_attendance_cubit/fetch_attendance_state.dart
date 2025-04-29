import 'package:equatable/equatable.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';

abstract class FetchAttendanceState extends Equatable {
  const FetchAttendanceState();

  @override
  List<Object> get props => [];
}

final class FetchAttendanceInitial extends FetchAttendanceState {}

class FetchAttendanceLoading extends FetchAttendanceState {}

class FetchAttendanceLoaded extends FetchAttendanceState {
  final List<AttendanceModel> model;

  const FetchAttendanceLoaded(this.model);
}

class FetchAttendanceError extends FetchAttendanceState {
  final String message;

  const FetchAttendanceError(this.message);
}
