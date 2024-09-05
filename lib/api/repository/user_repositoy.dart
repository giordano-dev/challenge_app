import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tecnofit_app/api/models/user_model.dart';

class UserRepository {
  final String apiUrl = 'https://reqres.in/api/users';

  // Buscar lista de usuários (página especificada)
  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> usersJson = data['data'];
      print(usersJson);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  // Buscar usuário por ID (opcional)
  Future<User> fetchUserById(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['data']);
    } else {
      throw Exception('Erro ao carregar usuário');
    }
  }
}
