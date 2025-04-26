import 'package:flutter/material.dart';

class DistanceError extends StatelessWidget {
  const DistanceError({super.key, required this.distance});
  final double distance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 150),
          Text(
            'انت بعيد عن موقع العمل',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: Colors.red),
          ),
          Text(
            '${distance.toStringAsFixed(3)} متر',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
