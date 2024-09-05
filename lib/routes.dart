import 'package:flutter/material.dart';
import 'package:tecnofit_app/ui/screens/user_list_screen.dart';
import 'package:tecnofit_app/ui/screens/user_detail_screen.dart';
import 'package:tecnofit_app/ui/screens/login_screen.dart';
import 'package:tecnofit_app/api/models/user_model.dart';

class AppRoutes {
  static const String login = '/login';
  static const String userList = '/userList';
  static const String userDetails = '/userDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case userList:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          final principalUser = args['principalUser'] as User;
          final users = args['users'] as List<User>;
          return MaterialPageRoute(
            builder: (_) => UserListScreen(
              principalUser: principalUser,
              users: users,
              onUserTap: (user) {
                Navigator.pushNamed(
                  _,
                  userDetails,
                  arguments: user,
                );
              },
            ),
          );
        }
        return _errorRoute();

      case userDetails:
        if (settings.arguments is User) {
          final user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => UserDetailScreen(user: user, principalUser: user),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Route not found'),
        ),
      ),
    );
  }
}
