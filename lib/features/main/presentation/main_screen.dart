import 'package:flutter/material.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_app_bar.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_body.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    //  MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (_) => EmployeeCubit()..fetchEmployee(phone)),
    //     BlocProvider(
    //       create: (_) => AttendantCubit()
    //         ..fetchMonthlyAttendance(phone, DateTime.now().year, DateTime.now().month),
    //     ),
    //   ],
    // child:
    Scaffold(
      appBar: mainAppBar(context),
      drawer: MainDrawer(),
      body: MainBody(),
    );
    // );
  }
}
