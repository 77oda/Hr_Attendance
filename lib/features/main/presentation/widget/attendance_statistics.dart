import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/main/presentation/widget/attendance_statistics_shimmer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_cubit.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_state.dart';

class AttendanceStatistics extends StatelessWidget {
  const AttendanceStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAttendanceCubit, FetchAttendanceState>(
      builder: (context, state) {
        if (state is FetchAttendanceLoaded) {
          final attendanceData = state.model;
          final totalDays = attendanceData.length;
          final presentDays =
              attendanceData.where((day) => day.status == 'حضور').length;
          final absentDays =
              attendanceData.where((day) => day.status == 'غياب').length;
          final leaveDays =
              attendanceData.where((day) => day.status == 'إجازة').length;

          final presentPercent = (presentDays / totalDays);
          final absentPercent = (absentDays / totalDays);
          final leavePercent = (leaveDays / totalDays);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedCircularIndicator(
                context: context,
                title: 'الحضور',
                percent: presentPercent,
                color: Colors.blue,
              ),
              SizedBox(width: 16.w),
              _buildAnimatedCircularIndicator(
                context: context,
                title: 'الغياب',
                percent: absentPercent,
                color: Colors.grey,
              ),
              SizedBox(width: 16.w),
              _buildAnimatedCircularIndicator(
                context: context,
                title: 'الإجازة',
                percent: leavePercent,
                color: Colors.green,
              ),
            ],
          );
        } else if (state is FetchAttendanceLoading) {
          return AttendanceStatisticsShimmer();
        } else if (state is FetchAttendanceError) {
          return Center(child: Text('فشل في تحميل الإحصائيات'));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildAnimatedCircularIndicator({
    required String title,
    required double percent,
    required Color color,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 5.h),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: percent),
          duration: const Duration(milliseconds: 1200),
          builder: (context, value, child) {
            return CircularPercentIndicator(
              radius: 50.0.r,
              lineWidth: 10.0.w,
              animation: false, // احنا عملنا الانيميشن يدوي
              percent: value.clamp(0.0, 1.0),
              center: Text(
                (value * 100).toStringAsFixed(1) == 'NaN'
                    ? '0%'
                    : "${(value * 100).toStringAsFixed(1)}%",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey.shade300,
              progressColor: color,
            );
          },
        ),
      ],
    );
  }
}
