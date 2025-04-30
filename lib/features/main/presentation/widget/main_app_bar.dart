import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_attendance/core/utils/app_router.dart';
import 'package:hr_attendance/core/widgets/app_logo.dart';

AppBar mainAppBar(context) {
  return AppBar(
    titleSpacing: 0,
    title: AppLogo(),
    actions: [
      Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: IconButton(
          icon: const Icon(Icons.fingerprint),
          onPressed: () async {
            GoRouter.of(context).push(AppRouter.attendanceScreen);
          },
        ),
      ),
    ],
  );
}
