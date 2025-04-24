import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_attendance/core/networking/firebase_failures.dart';
import 'package:hr_attendance/features/auth/data/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<Either<Failure, void>> sendOTP(String phoneNumber) async {
    try {
      var isAllowed = await isPhoneAllowed(phoneNumber);
      if (isAllowed) {
        // await FirebaseAuth.instance.verifyPhoneNumber(
        //   phoneNumber: '+2$phoneNumber',
        //   timeout: const Duration(seconds: 14),
        //   verificationCompleted: verificationCompleted,
        //   verificationFailed: (FirebaseAuthException error) {},
        //   codeSent: codeSent,
        //   codeAutoRetrievalTimeout: (String verificationId) {},
        // );
        return right(null);
      } else {
        return left(ServerFailure('رقم الهاتف غير مسموح به'));
      }
    } on FirebaseAuthException catch (error) {
      return left(ServerFailure.fromFirebaseAuth(error));
    } on FirebaseException catch (error) {
      return left(ServerFailure.fromFirebase(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  Future<bool> isPhoneAllowed(String phoneNumber) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(phoneNumber)
            .get();
    return doc.exists;
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await submitOTP(credential);
  }

  void codeSent(String verificationId, int? resendToken) {
    print('codeSent');
    this.verificationId = verificationId;
  }

  @override
  Future<Either<Failure, void>> submitOTP(
    PhoneAuthCredential credential,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return right(null);
    } on FirebaseAuthException catch (error) {
      return left(ServerFailure.fromFirebaseAuth(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
