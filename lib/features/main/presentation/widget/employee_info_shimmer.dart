import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeInfoShimmer extends StatelessWidget {
  const EmployeeInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        SizedBox(width: 10.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20.h,
            width: 150.w,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
