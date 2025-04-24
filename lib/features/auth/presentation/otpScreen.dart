import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/auth/presentation/widget/otp_widget/otp_button.dart';
import 'package:hr_attendance/features/auth/presentation/widget/otp_widget/otp_intro_text.dart';
import 'package:hr_attendance/features/auth/presentation/widget/otp_widget/otp_pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  // late String otpCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
          child: Column(
            children: [
              OtpIntroText(),
              SizedBox(height: 70.h),
              OtpPinCodeFields(),
              SizedBox(height: 70.h),
              OtpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
