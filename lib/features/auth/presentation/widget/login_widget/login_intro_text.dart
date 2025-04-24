import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginIntroText extends StatelessWidget {
  const LoginIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ما هو رقم هاتفك؟',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 30.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            'الرجاء إدخال رقم هاتفك للتحقق من حسابك.',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
