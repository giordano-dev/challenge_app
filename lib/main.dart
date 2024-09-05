import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecnofit_app/api/repository/user_repositoy.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:tecnofit_app/blocs/user_bloc/user_bloc.dart';
import 'package:tecnofit_app/routes.dart';
import 'package:tecnofit_app/api/repository/auth_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: UserRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Defina a rota inicial
        initialRoute: AppRoutes.login,
        // Use a propriedade routes ou onGenerateRoute para navegar
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
