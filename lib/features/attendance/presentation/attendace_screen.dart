import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool hasCheckedIn = false;

  // void initState() {
  //   super.initState();
  //   checkIfCheckedIn();
  // }
  // Future<void> checkIfCheckedIn() async {
  //   final result = await context.read<AttendantCubit>().checkTodayAttendance();
  //   setState(() {
  //     hasCheckedIn = result;
  //   });
  // }
  Future<void> handleAttendance() async {
    final position = await Geolocator.getCurrentPosition();
    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      30.123456, // إحداثيات الشركة - عدلها
      31.123456,
    );
    print(distance);

    // if (distance <= 50) {
    //   if (!hasCheckedIn) {
    //     // await context.read<AttendantCubit>().checkIn();
    //   } else {
    //     // await context.read<AttendantCubit>().checkOut();
    //   }
    //   // checkIfCheckedIn();
    // } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('أنت بعيد عن مقر الشركة')), // تنبيه للمستخدم
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الحضور والانصراف')),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            backgroundColor: hasCheckedIn ? Colors.red : Colors.green,
          ),
          icon: const Icon(Icons.fingerprint, size: 32),
          label: Text(
            hasCheckedIn ? 'تسجيل الانصراف' : 'تسجيل الحضور',
            style: const TextStyle(fontSize: 20),
          ),
          onPressed: handleAttendance,
        ),
      ),
    );
  }
}
