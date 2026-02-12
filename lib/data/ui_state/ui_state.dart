import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/enum/status.dart';

/// A generic UI state wrapper used to manage the lifecycle of a screen's data.
///
/// This class helps represent different states of the UI in a consistent way:
///
/// - INITIAL  → Default state before any action is triggered.
/// - LOADING  → When an API call or async operation is in progress.
/// - SUCCESS  → When data is successfully fetched or processed.
/// - ERROR    → When something goes wrong (API failure, validation issue, etc.).

class UIState<T> {
  Status? status;
  T? data;
  ErrorType? errorType;
  UIState(this.status, this.data, this.errorType);

  UIState.initial() : status = Status.INITIAL;
  UIState.loading() : status = Status.LOADING;
  UIState.success(this.data) : status = Status.SUCCESS;
  UIState.error(this.errorType) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $errorType \n Data : ${data.toString()}";
  }
}
