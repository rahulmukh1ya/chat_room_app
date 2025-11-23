part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  userAuthenticated,
  userUnauthenticated,
  authenticationError,
  loginSuccess,
  registerSuccess,
  loginError,
  registerError,
}

final class AuthState extends Equatable {
  final AuthStatus status;
  final String message;
  final UserEntity? user;
  const AuthState({
    this.status = AuthStatus.initial,
    this.message = '',
    this.user,
  });

  AuthState copyWith({AuthStatus? status, String? message, UserEntity? user}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? '',
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, message, user];
}
