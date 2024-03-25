
import '../data/data_source/user_lds.dart';
import '../data/models/user_model.dart';

class UsersRepository {
  UsersRepository(
    this.userLDS,
  );
  final UserLDS userLDS;


  Future<List<User>> getUsers() async {
  final users = await userLDS.getUsers();
  return users.map((e) => User.fromJson(e)).toList();
  }
}
