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
  bool _isObscure = true;

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

    handleAuthorize() {
      if (login == user.userLogin && password == user.userPassword) {
            getIt<AuthBloc>().add(SetAuthEvent(
              user: User(
                userId: user.userId,
                userName: user.userName,
                userLogin: login,
                userPassword: password,
                userAuthorized: true
                ),
              ),
            );
      }
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(user.userAuthorized ? 'Ваши данные' : 'Авторизация'),
      ),
      body: 
      Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Пользователь: ${user.userName}',
                style: const TextStyle(fontSize: 24.0),
              ),
              if (!user.userAuthorized)
                Column(
                  children: [
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
                      decoration: InputDecoration(
                        labelText: 'Введите пароль',
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                            });
                            },
                          ),
                      ),
                      obscureText: _isObscure,
                    ),
                    ElevatedButton(onPressed: () {
                      handleAuthorize();
                  }, child: const Text('Войти')),
                  ]
                ),
              
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