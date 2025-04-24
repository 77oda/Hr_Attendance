import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_attendance/core/helpers/cacheHelper.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/core/utils/app_router.dart';
import 'package:hr_attendance/core/widgets/custom_button.dart';
import 'package:hr_attendance/core/widgets/driver.dart';
import 'package:hr_attendance/features/main/logic/employee_cubit/employee_cubit.dart';
import 'package:hr_attendance/features/main/presentation/widget/employee_info.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, String value, context) {
    return ListTile(
      leading: Text(
        '$title:',
        style: Theme.of(context).textTheme.headlineMedium!,
      ),
      title: Text(value, style: Theme.of(context).textTheme.bodyMedium!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            final employee = state.employee;
            return Column(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: ColorsManager.primaryColor),
                  child: EmployeeInfo(colorText: Colors.white),
                ),
                MyDriver(),
                buildListTile('القسم', employee.department, context),
                MyDriver(),
                buildListTile('التخصص', employee.position, context),
                MyDriver(),
                buildListTile('رقم التليفون', employee.phone, context),
                MyDriver(),
                SizedBox(height: 20.h),
                Spacer(),
                CustomButton(
                  text: 'تسجيل الخروج',
                  onPressed: () async {
                    await CacheHelper.removeData('phone');
                    GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                  },
                  width: 150.w,
                ),
                SizedBox(height: 50.h),
              ],
            );
          } else if (state is EmployeeError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: SizedBox());
          }
        },
      ),
    );
  }
}
