import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_attendance/features/auth/data/repos/login_repo.dart';
import 'package:hr_attendance/features/auth/logic/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitialState());

  Future<void> sendOTP(String phoneNumber) async {
    emit(LoginLoadingState());
    final result = await loginRepo.sendOTP(phoneNumber);
    result.fold((l) => emit(LoginErrorState(errorMsg: l.errMessage)), (r) {
      emit(LoginSuccessState(phone: phoneNumber));
    });
  }

  Future<void> submitOtp(String otpCode) async {
    emit(SubmitOtpLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: loginRepo.verificationId,
      smsCode: otpCode,
    );
    final result = await loginRepo.submitOTP(credential);
    result.fold((l) => emit(SubmitOtpErrorState(errorMsg: l.errMessage)), (r) {
      emit(SubmitOtpSuccessState());
    });
  }

  // Future<void> logOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  // User getLoggedInUser() {
  //   User firebaseUser = FirebaseAuth.instance.currentUser!;
  //   return firebaseUser;
  // }
}
