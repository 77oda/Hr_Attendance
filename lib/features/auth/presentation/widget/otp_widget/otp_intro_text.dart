import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/features/auth/presentation/login_screen.dart';

class OtpIntroText extends StatelessWidget {
  const OtpIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التحقق من رقم هاتفك',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 30.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: RichText(
            text: TextSpan(
              text: 'أدخل أرقام الكود المكونة من 6 أرقام المرسلة إليك ',
              style: Theme.of(context).textTheme.headlineMedium,
              children: <TextSpan>[
                TextSpan(
                  text: phone,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: ColorsManager.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
