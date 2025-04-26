import 'package:flutter/services.dart';
import 'package:hr_attendance/core/widgets/show_snack_bar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class FingerprintAuth {
  static final LocalAuthentication localAuthentication = LocalAuthentication();
  static bool? checkEnabled;
  static bool? checkDevice;

  static Future isFingerPrintEnabled() async {
    bool fingerPrintEnabled = await localAuthentication.canCheckBiometrics;
    print('fingerPrintEnabled: $fingerPrintEnabled');
    checkEnabled = fingerPrintEnabled;
  }

  static Future isDeviceSupported() async {
    bool isDeviceSupported = await localAuthentication.isDeviceSupported();
    print('isDeviceSupported: $isDeviceSupported');
    checkDevice = isDeviceSupported;
  }

  // Handles the authentication process
  static Future<bool> isAuth(BuildContext context) async {
    try {
      bool auth = await localAuthentication.authenticate(
        localizedReason: 'أدخل بصمة الإصبع',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return auth;
    } on PlatformException catch (e) {
      if (e.code == 'LockedOut') {
        // Handle too many attempts
        showSnackBar(
          'لقد ادخلت عدد كبير جدًا من المحاولات، يحدث هذا بعد 5 محاولات فاشلة، حاول بعد 30 ثانية',
          context,
        );
        print('LockedOut error: $e');
      } else if (e.code == 'PermanentlyLockedOut') {
        // Handle permanently locked out
        showSnackBar(
          'لقد قمت بإدخال عدد كبير جدًا من المحاولات الخاطئة.\n'
          'يرجى فتح قفل الجهاز باستخدام كلمة المرور لاستعادة إمكانية استخدام البصمة.',
          context,
        );
        print('PermanentlyLockedOut error: $e');
      } else {
        print('Authentication error: $e');
      }
      return false;
    } catch (e) {
      print('Unknown error: $e');
      return false;
    }
  }
}
