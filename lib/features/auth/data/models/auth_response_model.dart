import 'package:chat_app/features/auth/data/models/user_model.dart';

class AuthResponseModel {
  final UserModel user;
  final String token;

  AuthResponseModel({required this.user, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json)  ,
      token: json['token'] ?? '' ,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': user.id, 'username': user.username, 'token': token};
  }
}
