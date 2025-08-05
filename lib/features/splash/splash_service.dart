import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/features/authentication/repository/user_information_repository.dart';

class SplashService{
  final UserInformationRepository _userInformationRepository;
  SplashService(this._userInformationRepository);

  Future<Result<bool>> checkIsUserLogin() async {
    String? userId = await _userInformationRepository.getUserID();
    if(userId != null){
      return const Success(true);
    }else{
      return Error(UnauthenticatedError());
    }
  }


}