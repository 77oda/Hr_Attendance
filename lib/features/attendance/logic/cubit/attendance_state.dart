import 'package:equatable/equatable.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError(this.message);
}

final class AttendanceSuccess extends AttendanceState {
  final String message;
  const AttendanceSuccess(this.message);
}

final class CheckInLoading extends AttendanceState {}

final class CheckInError extends AttendanceState {
  final String message;
  const CheckInError(this.message);
}

final class CheckInSuccess extends AttendanceState {}

final class CheckOutLoading extends AttendanceState {}

final class CheckOutError extends AttendanceState {
  final String message;
  const CheckOutError(this.message);
}

final class CheckOutSuccess extends AttendanceState {}
