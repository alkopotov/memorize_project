
import 'dart:convert';

import '../data/data_source/auth_lds.dart';
import '../data/models/user_model.dart';

class AuthRepository {
  AuthRepository(
    this.authorizeLDS,
  );
  final AuthorizeLDS authorizeLDS;


  Future<User> getUser() async {
  final user = await authorizeLDS.getUser();
  return User.fromJson(user);
  }

  Future<bool> setUser(User user) async {
    await authorizeLDS.writeData(jsonEncode(user.toJson()));
    return true;
  }

  Future<bool> deleteUser() async {
    await authorizeLDS.deleteData();
    return true;
  }
}
