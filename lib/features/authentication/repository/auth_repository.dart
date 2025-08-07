import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/data/storage/secured_shared_preferences.dart';
import 'package:flutter_mvvm_bloc_cubit/service/push_notification/notification_service.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

class AuthRepository {
  final SecuredSharedPreferences _securedSharedPref;
  final NotificationService _notificationService;
  AuthRepository(this._securedSharedPref, this._notificationService);

  // Save user data from login
  Future<Result<bool>> saveUserInfoFromLogin(dynamic user) async {
    try {
      final userData = user;
      await _securedSharedPref.saveKey(AppString.sessionKey.userId, userData.customerId.toString());
      CustomLog.debug(this, "Save user from login saved successfully");
      return const Success(true);
    } catch (e) {
      CustomLog.error(this, "Save Resident user info to preferences error", e);
      return Error(GenericError());
    }
  }


  // Clear auth & cache
  Future<void> _clearAuthData() async {
    await _securedSharedPref.reset();
    await _notificationService.clearBadgeCount();
    await _notificationService.clearFcmToken();
  }

  // Sign out
  Future<Result<bool>> signOut() async {
    try {
      await _clearAuthData();
      return const Success(true);
    } catch (e) {
      CustomLog.error(this, "SignOut attempt error", e);
      return Error(GenericError());
    }
  }



}