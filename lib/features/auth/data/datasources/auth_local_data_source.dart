import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

const cachedUser = 'CACHED_USER';

/// Abstract interface for local authentication data source
abstract class AuthLocalDataSource {
  /// Caches the user model
  Future<void> cacheUser(UserModel userToCache);

  /// Gets the cached user model
  Future<UserModel> getLastUser();

  /// Clears the cached user
  Future<void> clearUser();
}

/// Implementation of AuthLocalDataSource using SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return _sharedPreferences.setString(
      cachedUser,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<UserModel> getLastUser() {
    final jsonString = _sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw Exception('No cached user');
    }
  }

  @override
  Future<void> clearUser() {
    return _sharedPreferences.remove(cachedUser);
  }
}
