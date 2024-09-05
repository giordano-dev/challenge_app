import 'package:tecnofit_app/api/models/user_model.dart';

abstract class UserEvent {}

class FetchUsersEvent extends UserEvent {
  final int page;
  FetchUsersEvent(this.page);
}

class FetchUserByIdEvent extends UserEvent {
  final int userId;
  FetchUserByIdEvent(this.userId);
}

class DeleteUserEvent extends UserEvent {
  final int userId;
  final int currentIndex; // Índice do usuário atualmente selecionado
  final Function(int newIndex) updateCurrentIndex; // Função para atualizar o índice após remoção

  DeleteUserEvent(this.userId, this.currentIndex, this.updateCurrentIndex);
}

class AddUserEvent extends UserEvent {
  final User user;
  AddUserEvent(this.user);
}

class EditUserEvent extends UserEvent {
  final User user; // Usuário a ser editado

  EditUserEvent(this.user);
}
