import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/usecases/login_user_usercase.dart';
import 'package:chat_app/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUsercase loginUserUsercase;
  final RegisterUserUsecase registerUserUsecase;
  AuthBloc({required this.loginUserUsercase, required this.registerUserUsecase})
    : super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final userEntity = await loginUserUsercase(
        username: event.username,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.loginSuccess,
          user: userEntity,
          message: "Login Successful",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      await registerUserUsecase(
        username: event.username,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.registerSuccess,
          message: "Registration Successful",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }
}
