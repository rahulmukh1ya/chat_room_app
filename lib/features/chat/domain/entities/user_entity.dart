import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String userId;

  const UserEntity({required this.username, required this.userId});

  @override
  String toString() {
    return 'UserEntity { username: $username, userId: $userId }';
  }

  @override
  List<Object> get props => [username, userId];
}
