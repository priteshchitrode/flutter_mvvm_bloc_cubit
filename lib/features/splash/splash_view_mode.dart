import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/data/ui_state/ui_state.dart';
import 'package:flutter_mvvm_bloc_cubit/features/authentication/repository/auth_repository.dart';
import 'splash_repository.dart';

class SplashViewModel {
  final SplashRepository _splashRepository;
  final AuthRepository _authRepository;
  SplashViewModel(this._splashRepository, this._authRepository);

  UIState<bool>? _checkIsUserLoginUIState;
  UIState<bool>? get checkIsUserLoginUIState => _checkIsUserLoginUIState;
  void _setIsUserLoginUIState(UIState<bool>? value) {
    _checkIsUserLoginUIState = value;
  }

  Future<void> fetchIsUserLogin() async {
    Result result = await _splashRepository.getIsUserLogin();
    if (result is Success<bool>) {
      _setIsUserLoginUIState(UIState.success(result.value));
    }
    if (result is Error) {
      await _authRepository.signOut();
      _setIsUserLoginUIState(UIState.error(result.type));
    }
  }
}
