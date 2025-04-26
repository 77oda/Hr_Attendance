import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hr_attendance/core/utils/finger_print_auth.dart';
import 'package:hr_attendance/core/utils/location_service.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/distance_error.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/distance_success.dart';
import 'package:hr_attendance/features/attendance/presentation/widget/location_error.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  LocationService locationService = LocationService();
  double? currentDistance;
  Timer? retryTimer;
  bool locationError = false;
  bool isMockLocation = false;

  @override
  void initState() {
    super.initState();
    FingerprintAuth.isDeviceSupported();
    FingerprintAuth.isFingerPrintEnabled();
    startLocationTracking();
  }

  void startLocationTracking() {
    locationService
        .getPosition(
          (distance, position) {
            if (mounted) {
              setState(() {
                currentDistance = distance;
              });
            }
          },
          (error) {
            if (mounted) {
              showSnackBar(error, context); // ✨ تظهر رسالة الخطأ
              setState(() {
                isMockLocation = true;
              });
            }
          },
        )
        .catchError((error) {
          if (mounted) {
            showSnackBar(error.toString(), context);
          }
        });
    // تأكد من عدم إنشاء التايمر إذا كان يعمل بالفعل
    if (retryTimer == null ||
        !retryTimer!.isActive && isMockLocation == false) {
      retryTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
        bool enabled = await Geolocator.isLocationServiceEnabled();
        if (enabled) {
          locationError = false;
          retryTimer?.cancel(); // وقف التايمر إذا كانت خدمة الموقع مفعلة
          if (mounted) {
            startLocationTracking(); // إعادة تتبع الموقع
          }
        } else {
          if (mounted) {
            setState(() {
              locationError = true;
            });
            locationService
                .stopListening(); // إيقاف الاستماع إذا كانت خدمة الموقع غير مفعلة
          }
        }
      });
    }
  }

  @override
  void dispose() {
    locationService.stopListening();
    retryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تسجيل الحضور والانصراف',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Builder(
        builder: (_) {
          // إذا كانت خدمة الموقع غير مفعلة
          if (locationError) {
            return LocationError();
          }
          // إذا كانت المسافة غير موجودة (أي أن التطبيق لا يزال يقوم بتحميل الموقع)
          if (currentDistance == null) {
            return const Center(child: CircularProgressIndicator());
          }
          // إذا كانت المسافة أقل من 20 متر
          if (currentDistance! <= 25) {
            return DistanceSuccess();
          }
          // إذا كانت المسافة أكبر من 20 متر
          return DistanceError(distance: currentDistance!);
        },
      ),
    );
  }
}
