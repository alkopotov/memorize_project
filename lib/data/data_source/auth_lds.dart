import 'dart:convert';
import 'auth_local_storage.dart';

class AuthorizeLDS {

  Future<Map<String, dynamic>> getUser() async {

    final data = await AuthLocalStorage().readData();
    if (data == '') {
      return {
        'userId': '0',
        'userName': '',
        'userLogin': '',
        'userPassword': '',
        'userAuthorized': false
      };
    }
    return jsonDecode(data);
  }

  Future<void> writeData(String data) async {
    await AuthLocalStorage().writeData(data);
  }

  Future<void> deleteData() async {
    await AuthLocalStorage().deleteData();
  }
}