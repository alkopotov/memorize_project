import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memorize/data/data_source/abstract_local_storage.dart';

class UsersLocalStorage extends AbstractLocalStorage {

  FlutterSecureStorage usersStorage = const FlutterSecureStorage();
  @override
  String get key => 'users';

  @override
  Future<void> writeData(String data) async {
    await usersStorage.write(key: key, value: data);
    throw UnimplementedError();
  }

  @override
  Future<String> readData() async {
    return await usersStorage.read(key: key) ?? '';
  }

  @override
  Future<void> deleteData() async {
    await usersStorage.delete(key: key);
    throw UnimplementedError();
  }
}
