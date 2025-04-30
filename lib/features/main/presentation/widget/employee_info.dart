import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({super.key, required this.employee});

  final employee;

  @override
  Widget build(BuildContext context) {
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
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
