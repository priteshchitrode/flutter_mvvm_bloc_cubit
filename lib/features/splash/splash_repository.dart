import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';

import 'splash_service.dart';

class SplashRepository {
  final SplashService _splashService;
  SplashRepository(this._splashService);

  // Check user login
  Future<Result<bool>> getIsUserLogin() async {
    return await _splashService.checkIsUserLogin();
  }


}