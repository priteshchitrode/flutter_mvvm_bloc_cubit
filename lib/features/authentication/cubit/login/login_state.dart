part of 'login_cubit.dart';

class LoginState extends Equatable {
  final UIState<LoginModel>? loginUIState;
  const LoginState({
    this.loginUIState,
 });

  LoginState copyWith({
    UIState<LoginModel>? sendOtpState,
  }) {
    return LoginState(
      loginUIState: sendOtpState ?? this.loginUIState,
    );
  }

  @override
  List<Object?> get props => [
    loginUIState
  ];
}

