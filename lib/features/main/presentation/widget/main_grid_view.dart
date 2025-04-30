import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_cubit.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_state.dart';
import 'package:hr_attendance/features/main/presentation/widget/attendance_grid_view_shimmer.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_grid_view_item.dart';

class MainGridView extends StatelessWidget {
  const MainGridView({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'حضور':
        return Colors.blue;
      case 'غياب':
        return Colors.grey;
      case 'إجازة':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FetchAttendanceCubit, FetchAttendanceState>(
        builder: (context, state) {
          if (state is FetchAttendanceLoading) {
            return AttendanceGridViewShimmer();
          } else if (state is FetchAttendanceLoaded) {
            final attendanceData = state.model;
            return attendanceData.isEmpty
                ? Center(
                  child: Text(
                    'لا يوجد ايام تسجيل هذا الشهر',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                )
                : GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: attendanceData.length,
                  itemBuilder: (context, index) {
                    final day = attendanceData[index];
                    final statusColor = _getStatusColor(day.status);
                    return MainGridViewItem(day: day, statusColor: statusColor);
                  },
                );
          } else if (state is FetchAttendanceError) {
            return Center(
              child: Text('حدث خطأ في تحميل البيانات: ${state.message}'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
