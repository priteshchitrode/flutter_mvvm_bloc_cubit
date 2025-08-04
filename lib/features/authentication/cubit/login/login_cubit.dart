import 'package:equatable/equatable.dart';
import 'package:flutter_mvvm_bloc_cubit/core/reset_cubit_state.dart';
import 'package:flutter_mvvm_bloc_cubit/data/ui_state/ui_state.dart';
part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(const LoginState());



  // Sent Otp Api Call
  void _setSendOtpUIState(UIState<SendEmailOtpModel>? uiState){
    emit(state.copyWith(sendOtpState: uiState));
  }
  Future<void> sendOtp(String email, userId) async {
    _setSendOtpUIState(UIState.loading());
    Result result = await _repository.getSendOtpData(email, userId);
    if (result is Success<SendEmailOtpModel>) {
      _setSendOtpUIState(UIState.success(result.value));
    }
    if (result is Error) {
      _setSendOtpUIState(UIState.error(result.type));
    }
  }

}
