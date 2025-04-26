import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/core/utils/finger_print_auth.dart';
import 'package:hr_attendance/core/widgets/show_progress_indicator.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/attendance/data/model/checkType_enum.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_cubit.dart';
import 'package:hr_attendance/features/attendance/logic/cubit/attendance_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            SmoothPageIndicator(
              controller: onButtonController,
              effect: const WormEffect(
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1,
                activeDotColor: ColorsManager.primaryColor,
              ),
              count: 2,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 200.h,
              child: PageView.builder(
                controller: onButtonController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {},
                itemBuilder:
                    (context, index) => InkWell(
                      onTap: () {
                        if (FingerprintAuth.checkEnabled == true) {
                          if (FingerprintAuth.checkDevice == true) {
                            print('ssssssssssss');
                            FingerprintAuth.isAuth(context).then((value) {
                              if (value) {
                                if (index == 0) {
                                  BlocProvider.of<AttendanceCubit>(
                                    context,
                                  ).checkAttendance(CheckType.checkIn);
                                } else {
                                  BlocProvider.of<AttendanceCubit>(
                                    context,
                                  ).checkAttendance(CheckType.checkOut);
                                }
                              }
                            });
                          } else {
                            showSnackBar(
                              'يجب تسجيل بصمه للجهاز الخاص بك',
                              context,
                            );
                          }
                        }
                      },
                      child: circleButton[index],
                    ),
                itemCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> circleButton = [
  CircleAvatar(
    backgroundColor: Colors.green,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('عمل', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
        Text('9:00 AM', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
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
        Text('5:30 PM', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
        Text('خروج', style: TextStyle(fontSize: 25.sp, color: Colors.white)),
      ],
    ),
  ),
];
