import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;

  const UserEntity({required this.id, required this.username});

  @override
  List<Object> get props => [id, username];
}
