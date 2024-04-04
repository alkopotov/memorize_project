import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'abstract_local_storage.dart';

class WordListLocalStorage extends AbstractLocalStorage {
  FlutterSecureStorage wordListStorage = const FlutterSecureStorage();
  @override
  String get key => 'wordList';

  @override
  Future<void> writeData(String data) async {
    await wordListStorage.write(key: key, value: data);
    throw UnimplementedError();
  }

  @override
  Future<String> readData() async {
    return await wordListStorage.read(key: key) ?? '';
  }

  @override
  Future<void> deleteData() async {
    await wordListStorage.delete(key: key);
    throw UnimplementedError();
  }

}