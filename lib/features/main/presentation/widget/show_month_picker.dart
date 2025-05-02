import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/features/main/logic/fetch_attendance_cubit/fetch_attendance_cubit.dart';
import 'package:hr_attendance/features/main/logic/selected_date_cubit/selected_date_cubit.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class ShowMonthPicker extends StatelessWidget {
  const ShowMonthPicker({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              initialDate: selectedDate,
              firstDate: DateTime(2025, 3, 25),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              context.read<SelectedDateCubit>().changeDate(picked);
              context.read<FetchAttendanceCubit>().filterByMonth(picked);
            }
          },
          icon: Icon(Icons.calendar_month, color: ColorsManager.primaryColor),
        ),
      ],
    );
  }
}
