import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_events.dart';
import '../bloc/auth_states.dart';
import '../data/models/user_model.dart';
import '../main.dart';

class AuthorizePage extends StatefulWidget {
  const AuthorizePage({super.key});

  @override
  State<AuthorizePage> createState() => _AuthorizePageState();
}


class _AuthorizePageState extends State<AuthorizePage> {


  late User user;
  late String login = '';
  late String password = '';

  @override
  void initState() {
    getIt<AuthBloc>().add(GetAuthEvent());
    
    user = getIt<AuthBloc>().state is AuthLoadedState ? (getIt<AuthBloc>().state as AuthLoadedState).user : User(
      userId: '0',
      userName: '',
      userLogin: '',
      userPassword: '',
      userAuthorized: false
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: 
      Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(user.userName),
              TextField(
                onChanged: (value) {
                  login = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Введите логин',
                ),
              ),
          
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Введите пароль',
                ),
              ),
              ElevatedButton(onPressed: () {
                if (login == user.userLogin && password == user.userPassword) {
                  getIt<AuthBloc>().add(SetAuthEvent(user: User(
                    userId: user.userId,
                    userName: user.userName,
                    userLogin: login,
                    userPassword: password,
                    userAuthorized: true
                  )));
                }
              }, child: const Text('Войти')),
              ElevatedButton(
                onPressed: () {
                  getIt<AuthBloc>().add(RemoveAuthEvent());
                },
                child: const Text('Удалить регистрацию'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}