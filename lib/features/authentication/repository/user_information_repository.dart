import 'package:flutter_mvvm_bloc_cubit/data/storage/secured_shared_preferences.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';

class UserInformationRepository {
  final SecuredSharedPreferences _securedSharedPref;
  UserInformationRepository(this._securedSharedPref);


  Future<String?> getUserID() async {
    return await _securedSharedPref.get(AppString.sessionKey.userId);
  }

  Future<String?> getUsername() async {
    return  await _securedSharedPref.get(AppString.sessionKey.userFullName);
  }


  Future<String?> getAddress() async {
    return  await _securedSharedPref.get(AppString.sessionKey.userAddress);
  }


  Future<String?> getFcmToken() async {
    return  await _securedSharedPref.get(AppString.sessionKey.fcmToken);
  }


}