import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/features/auth/presentation/login_screen.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CountryCodePicker(
          onChanged: print,
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'EG',
          favorite: ['+20', 'EG'],
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: false,
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: ColorsManager.primaryColor,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال رقم هاتفك!';
                } else if (value.length < 11) {
                  return 'قصير جدًا لرقم هاتف!';
                }
                return null;
              },
              onSaved: (value) {
                phone = value!;
              },
            ),
          ),
        ),
      ],
    );
  }
}
