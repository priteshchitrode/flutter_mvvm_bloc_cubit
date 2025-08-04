import 'package:bloc/bloc.dart';
import 'package:flutter_mvvm_bloc_cubit/data/ui_state/ui_state.dart';
import 'package:flutter_mvvm_bloc_cubit/enum/status.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

abstract class BaseCubit<S> extends Cubit<S> {
  BaseCubit(super.initialState);

  /// Returns a fresh `UIState<T>` in the `INITIAL` status.
  UIState<T> resetUIState<T>(UIState<T>? uiState) {
    if (uiState == null) {
      return UIState<T>.initial();
    }
    if (uiState.data is List) {
      (uiState.data as List).clear();
    } else if (uiState.data != null) {
      uiState.data = null;
    }
    uiState.status = Status.INITIAL;
    uiState.errorType = null;
    CustomLog.info(this, "\nReset UI State & Clear Data model : ${T.toString()}  \nUI Status : ${uiState.status.toString()}, \nError Type : ${uiState.errorType}, \nData : ${uiState.data}");
    return UIState<T>.initial();
  }

}
