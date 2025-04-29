import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/main/data/model/attendance_model.dart';

class MainGridViewItem extends StatelessWidget {
  const MainGridViewItem({
    super.key,
    required this.day,
    required this.statusColor,
  });
  final AttendanceModel day;
  final Color statusColor;
  void showDateDetails(BuildContext context, day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'تفاصيل الحضور في ${day.date}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الحالة: ${day.status}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'دخول: ${day.checkIn.trim()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'خروج: ${day.checkOut.trim()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'إغلاق',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDateDetails(context, day);
      },
      child: Container(
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.date}', // عرض تاريخ اليوم
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              day.status, // عرض تاريخ اليوم
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
