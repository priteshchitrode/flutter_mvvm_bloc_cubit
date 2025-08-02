import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/enum/status.dart';

class UIState<T>{
  Status? status;
  T? data;
  ErrorType? errorType;
  UIState(this.status, this.data, this.errorType);

  UIState.initial() :  status = Status.INITIAL;
  UIState.loading() :  status = Status.LOADING;
  UIState.success(this.data) :  status = Status.SUCCESS;
  UIState.error(this.errorType) :  status = Status.ERROR;

  @override
  String toString(){
    return "Status : $status \n Message : $errorType \n Data : ${data.toString()}";
  }
}