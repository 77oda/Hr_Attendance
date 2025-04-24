import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMsg;
  LoginErrorState({required this.errorMsg});
}

class LoginSuccessState extends LoginState {
  final String phone;
  LoginSuccessState({required this.phone});
}

class SubmitOtpErrorState extends LoginState {
  final String errorMsg;
  SubmitOtpErrorState({required this.errorMsg});
}

class SubmitOtpSuccessState extends LoginState {}

class SubmitOtpLoadingState extends LoginState {}
