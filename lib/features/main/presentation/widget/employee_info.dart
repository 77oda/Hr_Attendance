import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:hr_attendance/features/main/logic/employee_cubit/employee_cubit.dart';
import 'package:hr_attendance/features/main/presentation/widget/employee_info_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({super.key, this.colorText});

  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const EmployeeInfoShimmer();
        } else if (state is EmployeeLoaded) {
          final employee = state.employee;
          return Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey[200], // خلفية أثناء التحميل
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: employee.image,
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) =>
                            Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10.h),
              Text(
                employee.name,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: colorText ?? ColorsManager.primaryColor,
                ),
              ),
            ],
          );
        } else if (state is EmployeeError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
