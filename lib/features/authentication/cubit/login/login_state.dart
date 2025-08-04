part of 'login_cubit.dart';

class LoginState extends Equatable {
  final UIState<SendEmailOtpModel>? sendOtpState;
  const LoginState({
    this.sendOtpState,
 });

  LoginState copyWith({
    UIState<SendEmailOtpModel>? sendOtpState,
  }) {
    return LoginState(
      sendOtpState: sendOtpState ?? this.sendOtpState,
    );
  }

  @override
  List<Object?> get props => [
    sendOtpState
  ];
}

