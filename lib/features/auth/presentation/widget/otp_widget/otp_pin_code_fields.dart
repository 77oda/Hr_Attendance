import 'package:flutter/material.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPinCodeFields extends StatelessWidget {
  const OtpPinCodeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: ColorsManager.grey,
        inactiveColor: ColorsManager.grey,
        inactiveFillColor: Colors.white,
        activeFillColor: ColorsManager.grey,
        selectedColor: ColorsManager.grey,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (submitedCode) {
        // otpCode = submitedCode;
      },
      onChanged: (value) {
        print(value);
      },
    );
  }
}
