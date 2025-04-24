import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  /// للتعامل مع Firebase Auth
  factory ServerFailure.fromFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return ServerFailure('رقم الهاتف غير صالح');
      case 'too-many-requests':
        return ServerFailure('عدد كبير من المحاولات، حاول لاحقًا');
      case 'user-disabled':
        return ServerFailure('تم تعطيل المستخدم');
      case 'invalid-verification-code':
        return ServerFailure('رمز التحقق غير صحيح');
      case 'session-expired':
        return ServerFailure('انتهت صلاحية الجلسة، حاول مرة أخرى');
      case 'network-request-failed':
        return ServerFailure('لا يوجد اتصال بالإنترنت');
      default:
        return ServerFailure('خطأ في المصادقة: ${e.message}');
    }
  }

  /// للتعامل مع Firestore, Storage, وغيره من Firebase Exceptions
  factory ServerFailure.fromFirebase(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return ServerFailure('لا تملك صلاحية الوصول إلى البيانات');
      case 'unavailable':
        return ServerFailure('الخدمة غير متاحة الآن، حاول لاحقًا');
      case 'not-found':
        return ServerFailure('العنصر غير موجود');
      case 'already-exists':
        return ServerFailure('العنصر موجود بالفعل');
      case 'cancelled':
        return ServerFailure('تم إلغاء العملية');
      case 'deadline-exceeded':
        return ServerFailure('انتهت مهلة العملية');
      case 'data-loss':
        return ServerFailure('فقدان في البيانات أثناء العملية');
      case 'resource-exhausted':
        return ServerFailure('تم استهلاك الموارد المحددة');
      case 'unauthenticated':
        return ServerFailure('يجب تسجيل الدخول أولاً');
      default:
        return ServerFailure('حدث خطأ: ${e.message}');
    }
  }
}
