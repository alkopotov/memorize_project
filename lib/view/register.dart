import 'package:flutter/material.dart';
import 'package:memorize/main.dart';
import 'package:uuid/uuid.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_events.dart';
import '../data/models/user_model.dart';


var uuid = const Uuid();

class RegisterPage extends StatefulWidget {
   const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name = '';

  late String login = '';

  late String password = '';

  late String passwordRepeat = '';

  handleSubmit() {
    if (password == passwordRepeat) {
      setState(() {
        getIt<AuthBloc>().add(SetAuthEvent(
          user: User(
            userId: uuid.v4(),
            userName: name,
            userLogin: login,
            userPassword: password,
            userAuthorized: false
          )
        ));
      });
      print('Пароли совпадают');



      // getIt<AuthorizeLDS>().writeData(
      //   jsonEncode({
      //     'userId': '0',
      //     'userName': name,
      //     'userLogin': login,
      //     'userPassword': password,
      //     'userAuthorized': false
      //   }
      // )
      // );


    }
    else {
      print('Пароли не совпадают');
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация нового пользователя'),
      ),
      body: Center(
        child: 
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(labelText: 'Имя пользователя'),
                ),
                TextField(
                  onChanged: (value) {
                    login = value;
                  },
                  decoration: const InputDecoration(labelText: 'Логин'),
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(labelText: 'Пароль'),
                ),
                TextField(
                  onChanged: (value) {
                    passwordRepeat = value;
                  },
                  decoration: const InputDecoration(labelText: 'Повторите пароль'),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: const Text('Зарегистрироваться'),
                ),)
              ],
                  ),
          ),
      )
    );
  }
}