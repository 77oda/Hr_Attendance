import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';

class MyDriver extends StatelessWidget {
  const MyDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 2.h, color: ColorsManager.primaryColor);
  }
}
