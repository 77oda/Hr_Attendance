import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/widgets/driver.dart';
import 'package:hr_attendance/features/main/logic/employee_cubit/employee_cubit.dart';
import 'package:hr_attendance/features/main/logic/selected_date_cubit/selected_date_cubit.dart';
import 'package:hr_attendance/features/main/presentation/widget/attendance_statistics.dart';
import 'package:hr_attendance/features/main/presentation/widget/main_grid_view.dart';
import 'package:hr_attendance/features/main/presentation/widget/show_month_picker.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return BlocBuilder<SelectedDateCubit, DateTime>(
            builder: (context, selectedDate) {
              return Column(
                children: [
                  ShowMonthPicker(selectedDate: selectedDate),
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
          );
        },
      ),
    );
  }
}
