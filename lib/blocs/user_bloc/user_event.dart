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
