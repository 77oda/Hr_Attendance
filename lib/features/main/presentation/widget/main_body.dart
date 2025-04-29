import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/core/widgets/driver.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_cubit.dart';
import 'package:hr_attendance/features/main/logic/selected_date_cubit/selected_date_cubit.dart';
import 'package:hr_attendance/features/main/presentation/widget/attendance_statistics.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: BlocBuilder<SelectedDateCubit, DateTime>(
        builder: (context, selectedDate) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.yMMMM().format(selectedDate),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    iconSize: 30.r,
                    onPressed: () async {
                      final picked = await showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2025, 3, 25),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        context.read<SelectedDateCubit>().changeDate(picked);
                        context.read<FetchAttendanceCubit>().filterByMonth(
                          picked,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              MyDriver(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'إحصائيات الحضور الشهري',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 15.h),
              AttendanceStatistics(),
              SizedBox(height: 25.h),
              MyDriver(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'جدول الحضور الشهري',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 15.h),
              MainGridView(),
            ],
          );
        },
      ),
    );
  }
}
