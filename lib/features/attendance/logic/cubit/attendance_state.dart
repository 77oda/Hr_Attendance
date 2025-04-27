import 'package:equatable/equatable.dart';

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

class AttendanceFetched extends AttendanceState {}

class AttendanceReset extends AttendanceState {}
