import 'package:chat_app/features/chat/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.username, required super.userId});

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      username: json?['username'] ?? '',
      userId: json?['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : userId,
      'username' : username
    };
  }
}
