import '../data/models/user_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoadedState extends UserStates {
  UserLoadedState(this.users);
  final List<User> users;
}

class UserErrorState extends UserStates {
  UserErrorState(this.message);
  final String message;
}