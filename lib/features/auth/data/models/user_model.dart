import 'package:chat_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.username});

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json?['user_id'] ?? '',
      username: json?['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': id, 'username': username};
  }
}
