import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String apiUrl = 'https://reqres.in/api/login';

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else if (response.statusCode == 400) {
      final data = jsonDecode(response.body);
      throw Exception(data['error'] ?? 'Erro desconhecido');
    } else {
      throw Exception('Erro ao fazer login. Verifique suas credenciais.');
    }
  }
}
