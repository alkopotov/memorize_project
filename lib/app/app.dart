import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/user_bloc.dart';
import 'package:memorize/bloc/user_events.dart';
import 'package:memorize/domain/users_repository.dart';
import 'package:memorize/main.dart';
import '../bloc/user_states.dart';
import '../view/authorize.dart';
import '../view/home.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    getIt.registerSingleton<UserBloc>(UserBloc(getIt<UsersRepository>())..add(GetUserEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Запомни слова',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocBuilder<UserBloc, UserStates>(
        bloc: getIt<UserBloc>(),
        builder: (context, state) {
          if (state is UserInitialState) {
            return const AuthorizePage();
          }
          if (state is UserLoadedState) {
            if (state.users.isEmpty) {
              return const AuthorizePage();
            }
            return const MyHomePage(title: 'Запомни слова');
          }
          return const MyHomePage(title: 'Запомни слова');
        }, 
    )
    );
  }
}
