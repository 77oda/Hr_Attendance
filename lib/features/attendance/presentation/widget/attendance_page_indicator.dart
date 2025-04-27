import 'package:flutter/material.dart';
import 'package:hr_attendance/core/theming/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AttendancePageIndicator extends StatelessWidget {
  const AttendancePageIndicator({super.key, required this.onButtonController});
  final PageController onButtonController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: onButtonController,
      effect: const WormEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 1,
        activeDotColor: ColorsManager.primaryColor,
      ),
      count: 2,
    );
  }
}
