part of 'employee_cubit.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final EmployeeModel employee;

  const EmployeeLoaded(this.employee);
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);
}
