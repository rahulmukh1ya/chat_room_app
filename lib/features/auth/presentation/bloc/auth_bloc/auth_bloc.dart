
import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:chat_app/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:chat_app/features/auth/domain/usecases/login_user_usercase.dart';
import 'package:chat_app/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUsercase loginUserUsercase;
  final RegisterUserUsecase registerUserUsecase;
  final CheckAuthStatusUsecase checkAuthStatusUsecase;
  final GetUserDataUsecase getUserDataUsecase;
  AuthBloc({
    required this.loginUserUsercase,
    required this.registerUserUsecase,
    required this.checkAuthStatusUsecase,
    required this.getUserDataUsecase,
  }) : super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
  }

  Future<void> _onCheckAuthStatusEvent(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isLoggedIn = await checkAuthStatusUsecase();
      if (isLoggedIn) {
        final userEntity = await getUserDataUsecase();

        emit(
          state.copyWith(
            status: AuthStatus.userAuthenticated,
            user: userEntity,
          ),
        );
      } else {
        emit(state.copyWith(status: AuthStatus.userUnauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticationError,
          message: e.toString(),
        ),
      );
    }
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
      emit(
        state.copyWith(status: AuthStatus.loginError, message: e.toString()),
      );
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
      emit(
        state.copyWith(status: AuthStatus.registerError, message: e.toString()),
      );
    }
  }
}
