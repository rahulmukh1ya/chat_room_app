import 'dart:developer';

import 'package:chat_app/common/constants/api_constants.dart';
import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponseModel> loginUser(String username, String password);
  Future<void> registerUser(String username, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioHttpClient client;
  final ConnectivityCheck connectivity;

  AuthRemoteDatasourceImpl({required this.client, required this.connectivity});
  @override
  Future<AuthResponseModel> loginUser(String username, String password) async {
    final response = client.post(
      ApiConstants.baseUrl,
      body: {'username': username, 'password': password},
    );

    log(response.toString());

    final authResponseModel = AuthResponseModel.fromJson(
      response as Map<String, dynamic>,
    );

    return authResponseModel;
  }

  @override
  Future<void> registerUser(String username, String password) async {
    final response = client.post(
      ApiConstants.baseUrl,
      body: {'username': username, 'password': password},
    );

    log(response.toString());
  }
}
