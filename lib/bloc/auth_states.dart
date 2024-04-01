import '../data/models/user_model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthLoadedState extends AuthStates {
  AuthLoadedState(this.user);
  final User user;
}

class AuthErrorState extends AuthStates {
  AuthErrorState(this.message);
  final String message;
}

class UserSavingState extends AuthStates {}

class UserDeletingState extends AuthStates {}