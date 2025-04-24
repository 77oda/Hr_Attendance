import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_attendance/core/helpers/cacheHelper.dart';
import 'package:hr_attendance/core/utils/app_router.dart';
import 'package:hr_attendance/core/utils/constants.dart';
import 'package:hr_attendance/core/widgets/custom_button.dart';
import 'package:hr_attendance/core/widgets/show_progress_indicator.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_state.dart';
import 'package:hr_attendance/features/auth/presentation/login_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.phoneFormKey});
  final GlobalKey<FormState> phoneFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (previous, current) =>
              current is LoginSuccessState ||
              current is LoginErrorState ||
              current is LoginLoadingState,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          showProgressIndicator(context);
        }

        if (state is LoginSuccessState) {
          phoneNumber = state.phone;
          CacheHelper.setData(key: 'phone', value: state.phone);
          Navigator.pop(context);
          GoRouter.of(context).push(AppRouter.otpScreen);
        }

        if (state is LoginErrorState) {
          Navigator.pop(context);
          showSnackBar(state.errorMsg, context);
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomButton(
          width: 120.w,
          text: 'تسجيل',
          onPressed: () {
            if (phoneFormKey.currentState!.validate()) {
              phoneFormKey.currentState!.save();
              context.read<LoginCubit>().sendOTP(phone);
            }
          },
        ),
      ),
    );
  }
}
