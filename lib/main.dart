import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memorize/data/data_source/user_lds.dart';
import 'package:memorize/domain/users_repository.dart';
import 'app/app.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UserLDS>(UserLDS());
  getIt.registerSingleton<UsersRepository>(UsersRepository(getIt<UserLDS>()));
  runApp(const MyApp());
}

