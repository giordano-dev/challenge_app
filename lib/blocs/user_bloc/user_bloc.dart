import 'package:bloc/bloc.dart';
import 'package:tecnofit_app/api/repository/user_repositoy.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:tecnofit_app/api/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<User> _users = []; // Lista de usuários para manipulação interna

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await userRepository.fetchUsers(event.page);
        _users = users;
        emit(UserListLoadedState(_users));
      } catch (error) {
        emit(UserErrorState("Erro ao carregar a lista de usuários"));
      }
    });

    on<FetchUserByIdEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await userRepository.fetchUserById(event.userId);
        emit(UserLoadedState(user));
      } catch (error) {
        emit(UserErrorState("Erro ao carregar o usuário"));
      }
    });
  }
}
