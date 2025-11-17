import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/common/exceptions/custom_exception.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> saveUserData(UserModel user);
  Future<UserModel> getUserData();
  Future<void> removeUserData();
  Future<void> setLoggedIn(bool value);
  Future<bool> isLoggedIn();
  Future<void> saveAccessToken(String accessToken);
  Future<String> getAccessToken();
  Future<void> removeAccessToken();

  Future<void> clearAllAuthData();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences prefs;

  AuthLocalDatasourceImpl({required this.prefs});

  // Keys as constants to avoid typos
  static const String _userDataKey = 'userDataKey';
  static const String _accessTokenKey = 'userAccessToken';
  static const String _isLoggedInKey = 'isLoggedIn';

  @override
  Future<UserModel> getUserData() async {
    final data = prefs.getString(_userDataKey);
    if (data != null) {
      final user = UserModel.fromJson(jsonDecode(data));
      return user;
    } else {
      throw CustomException('User data not found');
    }
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    // Save all data in parallel but wait for all to complete
    await Future.wait([
      prefs.setString(_userDataKey, jsonEncode(user.toJson())),
    ]);
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    await prefs.setBool(_isLoggedInKey, value);
  }

  @override
  Future<bool> isLoggedIn() async {
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  @override
  Future<String> getAccessToken() async {
    final token = prefs.getString(_accessTokenKey) ?? '';
    log(
      '🔍 Retrieved access token: ${token.isNotEmpty ? '${token.substring(0, 20)}...' : 'EMPTY'}',
    );
    return token;
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await prefs.setString(_accessTokenKey, accessToken);
    log(
      '💾 Saved new access token: ${accessToken.isNotEmpty ? '${accessToken.substring(0, 20)}...' : 'EMPTY'}',
    );
  }

  @override
  Future<void> removeAccessToken() async {
    await prefs.remove(_accessTokenKey);
    log('🗑️ Removed access token');
  }

  @override
  Future<void> removeUserData() async {
    await prefs.remove(_userDataKey);
    log('🗑️ Removed user data');
  }

  // Add method to clear all authentication data at once
  @override
  Future<void> clearAllAuthData() async {
    await Future.wait([
      prefs.remove(_userDataKey),
      prefs.remove(_accessTokenKey),
      prefs.setBool(_isLoggedInKey, false),
    ]);
    log('🧹 Cleared all auth data');
  }
}
