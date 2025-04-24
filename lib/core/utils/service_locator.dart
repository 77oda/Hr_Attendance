import 'package:get_it/get_it.dart';
import 'package:hr_attendance/features/auth/data/repos/login_repo_impl.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo.dart';
import 'package:hr_attendance/features/main/data/repos/main_repo_impl.dart';
import 'package:hr_attendance/features/main/logic/employee_cubit/employee_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  //login
  getIt.registerLazySingleton<LoginRepoImpl>(() => LoginRepoImpl());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepoImpl>()));

  //main
  getIt.registerLazySingleton<MainRepoImpl>(() => MainRepoImpl());

  // employee
  getIt.registerFactory<EmployeeCubit>(
    () => EmployeeCubit(getIt<MainRepoImpl>()),
  );
}
