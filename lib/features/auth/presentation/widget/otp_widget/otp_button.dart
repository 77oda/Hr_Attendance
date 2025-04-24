import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_attendance/core/utils/app_router.dart';
import 'package:hr_attendance/core/widgets/custom_button.dart';
import 'package:hr_attendance/core/widgets/show_progress_indicator.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_state.dart';

class OtpButton extends StatelessWidget {
  const OtpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (previous, current) =>
              current is SubmitOtpSuccessState ||
              current is SubmitOtpErrorState ||
              current is SubmitOtpLoadingState,
      listener: (context, state) {
        if (state is SubmitOtpLoadingState) {
          showProgressIndicator(context);
        }

        if (state is SubmitOtpSuccessState) {
          Navigator.pop(context);
          GoRouter.of(context).push(AppRouter.mainScreen);
        }

        if (state is SubmitOtpErrorState) {
          Navigator.pop(context);
          showSnackBar(state.errorMsg, context);
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomButton(
          width: 120.w,
          text: 'تحقق',
          onPressed: () {
            // context.read<LoginCubit>().submitOtp();
            GoRouter.of(context).pushReplacement(AppRouter.mainScreen);
          },
        ),
      ),
    );
  }
}
