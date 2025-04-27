import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  StreamSubscription<Position>? _positionStream;
  double? distance;

  final double targetLat = 30.125793;
  final double targetLng = 31.309435;

  Future<void> stopListening() async {
    await _positionStream?.cancel();
    _positionStream = null;
  }

  Future<StreamSubscription<Position>?> getPosition(
    Function(double distance, Position position) onUpdate,
    Function(String error) onError, // هنا ضفنا onError
  ) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('تم رفض صلاحية الوصول للموقع.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'صلاحية الموقع مرفوضة بشكل دائم. الرجاء تفعيلها من الإعدادات.',
      );
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen(
      (Position? position) async {
        if (position != null) {
          // if (isMockLocation(position)) {
          //   await stopListening();
          //   onError('الموقع مزيف. يرجى التأكد من إعدادات الجهاز.');
          //   return;
          // }
          distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            targetLat,
            targetLng,
          );

          onUpdate(distance!, position);
        }
      },
      onError: (error) async {
        await stopListening();
      },
      cancelOnError: true,
    );

    return _positionStream;
  }

  bool isMockLocation(Position position) {
    // من خلال مقارنة إحداثيات الموقع أو الوقت (مقارنة التوقيت الفعلي)
    // يمكننا تحديد إذا كان الموقع مزيفًا أم لا

    // التحقق من دقة الموقع أو قياس المسافة بين الموقع الحالي والموقع المستهدف
    // يمكننا التحقق من أنه ليس بالقرب من الموقع المستهدف بشكل غير طبيعي

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final positionTime = position.timestamp.millisecondsSinceEpoch;

    // نفترض أن الموقع المزيف يظهر تأخيرًا غير طبيعي
    final timeDiff = currentTime - positionTime;

    // إذا كان فرق الزمن كبيرًا جدًا (أكثر من 5 دقائق، على سبيل المثال)
    if (timeDiff > 5 * 60 * 1000) {
      return true;
    }

    // التحقق من الإحداثيات - إذا كانت لا تطابق بشكل معقول الموقع
    final diffLat = (position.latitude - targetLat).abs();
    final diffLng = (position.longitude - targetLng).abs();

    // إذا كانت الإحداثيات بعيدة جدًا، ربما الموقع مزيف
    if (diffLat > 0.01 || diffLng > 0.01) {
      return true;
    }

    return false; // إذا كانت الإحداثيات دقيقة بما فيه الكفاية
  }
}
