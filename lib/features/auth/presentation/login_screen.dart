import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/features/auth/presentation/widget/login_widget/login_button.dart';
import 'package:hr_attendance/features/auth/presentation/widget/login_widget/login_form_field.dart';
import 'package:hr_attendance/features/auth/presentation/widget/login_widget/login_intro_text.dart';

String phone = '';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> phoneFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: phoneFormKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginIntroText(),
                  SizedBox(height: 70.h),
                  LoginFormField(),
                  SizedBox(height: 70.h),
                  LoginButton(phoneFormKey: phoneFormKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
