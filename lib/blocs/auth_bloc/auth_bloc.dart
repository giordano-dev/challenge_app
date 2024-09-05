import 'package:bloc/bloc.dart';
import 'package:tecnofit_app/api/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        // Chama o repositório para realizar o login
        final token = await authRepository.login(event.email, event.password);
        emit(AuthLoggedInState(token));
      } catch (error) {
        emit(AuthErrorState(error.toString())); // Exibe o erro adequado
      }
    });

    on<AuthLogoutEvent>((event, emit) {
      emit(AuthLoggedOutState());
    });
  }
}
