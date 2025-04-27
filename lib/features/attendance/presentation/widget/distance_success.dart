import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/widgets/show_progress_indicator.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_cubit.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_state.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/attendance_buttons.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/attendance_page_indicator.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/attendance_table.dart';

class DistanceSuccess extends StatefulWidget {
  const DistanceSuccess({super.key});

  @override
  State<DistanceSuccess> createState() => _DistanceSuccessState();
}

class _DistanceSuccessState extends State<DistanceSuccess> {
  late final PageController onButtonController;
  @override
  void initState() {
    super.initState();
    onButtonController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceSuccess) {
          Navigator.pop(context);
          showSnackBar(state.message, context);
        } else if (state is AttendanceError) {
          Navigator.pop(context);
          showSnackBar(state.message, context);
        } else if (state is AttendanceLoading) {
          showProgressIndicator(context);
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AttendancePageIndicator(onButtonController: onButtonController),
            SizedBox(height: 30.h),
            AttendanceButtons(onButtonController: onButtonController),
            SizedBox(height: 30.h),
            if (context.watch<AttendanceCubit>().checkInMap != null)
              AttendanceTable(),
          ],
        ),
      ),
    );
  }
}
