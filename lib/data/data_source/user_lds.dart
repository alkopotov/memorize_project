import 'dart:convert';
import 'users_local_storage.dart';

class UserLDS {

  Future<List<Map<String, dynamic>>> getUsers() async {

    final data = await UsersLocalStorage().readData();
    if (data == '') {
      return [];
    }
    return jsonDecode(data).toList();
  }
  
}