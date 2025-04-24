import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  late String verificationId;
  Future<Either<Failure, void>> sendOTP(String phoneNumber);
  Future<Either<Failure, void>> submitOTP(PhoneAuthCredential credential);
}
