import 'package:tecnofit_app/api/repository/auth_repository.dart';
import 'package:tecnofit_app/api/repository/user_repositoy.dart';
import 'models/user_model.dart';

class ReqresApi {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  ReqresApi({
    required this.userRepository,
    required this.authRepository,
  });

  Future<List<User>> getUsers(int page) async {
    return await userRepository.fetchUsers(page);
  }

  Future<User> getUserById(int id) async {
    return await userRepository.fetchUserById(id);
  }

  Future<String> loginUser(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
