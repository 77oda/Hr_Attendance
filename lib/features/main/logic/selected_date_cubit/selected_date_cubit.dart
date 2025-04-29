import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedDateCubit extends Cubit<DateTime> {
  SelectedDateCubit() : super(DateTime.now());

  void changeDate(DateTime date) => emit(date);
}
