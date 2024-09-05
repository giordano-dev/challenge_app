import 'package:bloc/bloc.dart';
import 'package:tecnofit_app/api/repository/user_repositoy.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:tecnofit_app/api/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<User> _users = []; // Lista de usuários para manipulação interna

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    // Buscar a lista de usuários
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        // Chamada à API para buscar os usuários da página
        final users = await userRepository.fetchUsers(event.page);
        _users = users; // Atualiza a lista interna de usuários
        emit(UserListLoadedState(_users));
      } catch (error) {
        emit(UserErrorState("Erro ao carregar a lista de usuários"));
      }
    });

    // Buscar um único usuário por ID
    on<FetchUserByIdEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await userRepository.fetchUserById(event.userId);
        emit(UserLoadedState(user));
      } catch (error) {
        emit(UserErrorState("Erro ao carregar o usuário"));
      }
    });

    // Deletar um usuário (não faz requisição API, apenas remove da lista local)
    on<DeleteUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        // Remove o usuário da lista interna
        _users.removeWhere((user) => user.id == event.userId);

        // Verifica se o índice _current está fora do range e ajusta se necessário
        if (event.currentIndex >= _users.length && _users.isNotEmpty) {
          event.updateCurrentIndex(_users.length - 1);
        }

        emit(UserListLoadedState(_users)); // Atualiza o estado com a nova lista
      } catch (error) {
        emit(UserErrorState("Erro ao deletar o usuário"));
      }
    });

    // Editar um usuário (simulando localmente)
    on<EditUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        // Simulando a edição do usuário localmente
        final index = _users.indexWhere((user) => user.id == event.user.id);
        if (index != -1) {
          _users[index] = event.user; // Atualiza o usuário localmente
          emit(UserListLoadedState(_users)); // Atualiza a lista no estado
        }
      } catch (error) {
        emit(UserErrorState("Erro ao editar o usuário"));
      }
    });
  }
}
