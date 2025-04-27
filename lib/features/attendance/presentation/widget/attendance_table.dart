import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_cubit.dart';

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              'وردية',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.green, radius: 5.r),
                SizedBox(width: 5.w),
                Text(
                  'دخول',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          DataColumn(
            label: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.red, radius: 5.r),
                SizedBox(width: 5.w),
                Text(
                  'خروج',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(
                Text('عمل', style: Theme.of(context).textTheme.headlineSmall),
              ),
              DataCell(
                Text(
                  '${context.watch<AttendanceCubit>().checkInMap!['time']}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              DataCell(
                Text(
                  '${context.watch<AttendanceCubit>().checkOutMap?['time'] ?? ''}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ],
        dataRowHeight: 30.h,
        headingRowHeight: 30.h,
        border: TableBorder.all(color: Colors.grey),
      ),
    );
  }
}
