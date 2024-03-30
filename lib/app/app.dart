import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/auth_bloc.dart';
import 'package:memorize/domain/auth_repository.dart';
import 'package:memorize/main.dart';
import 'package:memorize/view/register.dart';
import '../bloc/auth_events.dart';
import '../bloc/auth_states.dart';
import '../data/data_source/auth_lds.dart';
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
    getIt.registerSingleton<AuthorizeLDS>(AuthorizeLDS());
    getIt.registerSingleton<AuthRepository>(AuthRepository(getIt<AuthorizeLDS>()));
    getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthRepository>())..add(GetAuthEvent()));
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
      home: BlocBuilder<AuthBloc, AuthStates>(
        bloc: getIt<AuthBloc>(),
        builder: (context, state) {
          if (state is AuthInitialState) {
            return const AuthorizePage();
          }
          if (state is AuthLoadedState) {
            if (state.user.userId == '0') {
              return const RegisterPage();
            }
            if (!state.user.userAuthorized) {
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
