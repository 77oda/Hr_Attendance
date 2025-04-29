import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceStatisticsShimmer extends StatelessWidget {
  const AttendanceStatisticsShimmer({super.key});

  Widget _buildShimmerCircularIndicator() {
    return Column(
      children: [
        SizedBox(height: 7.5.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: 60.w, height: 16.h, color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildShimmerCircularIndicator(),
        SizedBox(width: 16.w),
        _buildShimmerCircularIndicator(),
        SizedBox(width: 16.w),
        _buildShimmerCircularIndicator(),
      ],
    );
  }
}
