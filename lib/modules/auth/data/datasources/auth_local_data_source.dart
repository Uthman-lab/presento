part of '../data.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<bool> isSessionValid();
  Future<void> cacheLastLogin();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  const AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await sharedPreferences.setString(AppConstants.userDataKey, userJson);
    await cacheLastLogin();
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = sharedPreferences.getString(AppConstants.userDataKey);
    if (userJson == null) return null;

    final userMap = json.decode(userJson) as Map<String, dynamic>;
    return UserModel.fromJson(userMap);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(AppConstants.userDataKey);
    await sharedPreferences.remove(AppConstants.lastLoginKey);
    await sharedPreferences.remove(AppConstants.currentInstitutionKey);
  }

  @override
  Future<bool> isSessionValid() async {
    try {
      final lastLoginString = sharedPreferences.getString(
        AppConstants.lastLoginKey,
      );
      if (lastLoginString == null) return false;

      final lastLogin = DateTime.parse(lastLoginString);
      return !lastLogin.isSessionExpired;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> cacheLastLogin() async {
    final now = DateTime.now().toIso8601String();
    await sharedPreferences.setString(AppConstants.lastLoginKey, now);
  }
}
