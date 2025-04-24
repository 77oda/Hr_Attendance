import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_attendance/features/main/data/model/empoloyee.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(this.mainRepo) : super(EmployeeInitial());
  final MainRepo mainRepo;

  Future<void> fetchEmployee() async {
    emit(EmployeeLoading());
    final result = await mainRepo.fetchEmployee();
    result.fold((l) => emit(EmployeeError(l.errMessage)), (r) {
      emit(EmployeeLoaded(r));
    });
  }
}
