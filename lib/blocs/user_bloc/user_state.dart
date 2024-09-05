import 'package:tecnofit_app/api/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserListLoadedState extends UserState {
  final List<User> users;
  UserListLoadedState(this.users);
}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
