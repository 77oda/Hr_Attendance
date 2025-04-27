import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_attendance/core/helpers/cacheHelper.dart';
import 'package:hr_attendance/core/theming/constants.dart';
import 'package:hr_attendance/core/utils/service_locator.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_cubit.dart';
import 'package:hr_attendance/features/attendance/presentation/attendace_screen.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:hr_attendance/features/auth/presentation/login_screen.dart';
import 'package:hr_attendance/features/auth/presentation/otpScreen.dart';
import 'package:hr_attendance/features/main/logic/employee_cubit/employee_cubit.dart';
import 'package:hr_attendance/features/main/presentation/main_screen.dart';

abstract class AppRouter {
  static const loginScreen = '/LoginScreen';
  static const otpScreen = '/OtpScreen';
  static const mainScreen = '/MainScreen';
  static const attendanceScreen = '/AttendanceScreen';

  static late String initialRoute;

  static Future<void> getInitialRoute() async {
    final phone = await CacheHelper.getData(key: 'phone') ?? '';

    if (phone == '') {
      initialRoute = loginScreen;
    } else {
      phoneNumber = phone;
      initialRoute = mainScreen;
    }
  }

  static final router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: loginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: LoginScreen(),
            ),
      ),

      GoRoute(
        path: otpScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: getIt<LoginCubit>(),
              child: OtpScreen(),
            ),
      ),

      GoRoute(
        path: mainScreen,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<EmployeeCubit>()..fetchEmployee(),
                ),
              ],
              child: MainScreen(),
            ),
      ),

      GoRoute(
        path: attendanceScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => getIt<AttendanceCubit>()..fetchTodayAttendance(),
              child: AttendanceScreen(),
            ),
      ),
    ],
  );
}
