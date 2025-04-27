import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/utils/finger_print_auth.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_cubit.dart';

class AttendanceButtons extends StatelessWidget {
  AttendanceButtons({super.key, required this.onButtonController});
  final PageController onButtonController;

  List<Widget> circleButton = [
    CircleAvatar(
      backgroundColor: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('عمل', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
          Text(
            '9:00ص - 9:15ص',
            style: TextStyle(fontSize: 25.sp, color: Colors.white),
          ),
          Text('دخول', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
        ],
      ),
    ),
    CircleAvatar(
      backgroundColor: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('عمل', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
          Text(
            '5:00 م',
            style: TextStyle(fontSize: 25.sp, color: Colors.white),
          ),
          Text('خروج', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      width: 270.w,
      child: PageView.builder(
        controller: onButtonController,
        itemBuilder:
            (context, index) => InkWell(
              onTap: () {
                if (FingerprintAuth.checkEnabled == true) {
                  if (FingerprintAuth.checkDevice == true) {
                    FingerprintAuth.isAuth(context).then((value) {
                      var cubit = BlocProvider.of<AttendanceCubit>(context);
                      if (value) {
                        index == 0
                            ? cubit.checkAttendance(CheckType.checkIn)
                            : cubit.checkAttendance(CheckType.checkOut);
                      }
                    });
                  } else {
                    showSnackBar('يجب تسجيل بصمه للجهاز الخاص بك', context);
                  }
                }
              },
              child: circleButton[index],
            ),
        itemCount: 2,
      ),
    );
  }
}
