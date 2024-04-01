import '../data/models/user_model.dart';

abstract class AuthEvents {}

class GetAuthEvent extends AuthEvents {}

class SetAuthEvent extends AuthEvents {
  SetAuthEvent({required this.user});
  final User user;
}

class RemoveAuthEvent extends AuthEvents {}
