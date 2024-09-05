import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_event.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_state.dart';
import 'package:tecnofit_app/blocs/user_bloc/user_bloc.dart';
import 'package:tecnofit_app/blocs/user_bloc/user_event.dart';
import 'package:tecnofit_app/blocs/user_bloc/user_state.dart';
import 'package:flutter/services.dart'; // Import necessário para copiar para a área de transferência

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final isEmailNotEmpty = _emailController.text.isNotEmpty;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isEmailNotEmpty && isPasswordNotEmpty;
    });
  }

  void _login(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(email, password));
  }

  void _showHintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dica de Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tente realizar o login com as seguintes credenciais:'),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('E-mail: '),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: 'eve.holt@reqres.in'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('E-mail copiado!')),
                      );
                    },
                    child: const SelectableText(
                      'eve.holt@reqres.in',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Senha: '),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: 'cityslicka'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Senha copiada!')),
                      );
                    },
                    child: const SelectableText(
                      'cityslicka',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8EA63),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showHintDialog(context); // Mostra a dica de login
        },
        backgroundColor: const Color(0xffF8EA63),
        child: const Icon(Icons.help, color: Colors.black), // Ícone de interrogação
      ),
      body: Center(
        child: SingleChildScrollView(
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    BlocProvider.of<UserBloc>(context).add(FetchUsersEvent(2));
                  } else if (state is AuthErrorState) {
                    setState(() {
                      _errorMessage = state.message;
                    });
                  }
                },
              ),
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserListLoadedState) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/userList',
                      arguments: {
                        'users': state.users,
                        'principalUser': state.users.first,
                      },
                    );
                  } else if (state is UserErrorState) {
                    setState(() {
                      _errorMessage = state.message;
                    });
                  }
                },
              ),
            ],
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Container(
                  width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * 0.8 : 400,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem-vindo ao Tecnofit App!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Olá!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Acesse a sua conta para visualizar os seus dados.',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              if (_errorMessage != null)
                                Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: state is AuthLoadingState
                                    ? const Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xffF8EA63),
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                        ),
                                        onPressed: _isButtonEnabled ? () => _login(context) : null,
                                        child: const Text(
                                          'Entrar',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
