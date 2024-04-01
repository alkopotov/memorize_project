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

  late String messagePass = '';

  late String messageName = '';

  late String messageLogin = '';

  bool _isObscure = true;

  handleSubmit() {

    if (name == '') {
      messageName = 'Заполните поле имя';
    } else {
      messageName = '';
    }

    if (login == '') {
      messageLogin = 'Заполните поле логин';  
    } else {
      messageLogin = '';
    }
    if (password == '') {
      messagePass = 'Заполните поле пароль';
    } 
    else if (password != passwordRepeat) {
      messagePass = 'Пароли не совпадают';
      
    }
    
    setState(() {
        
      });

    if (password == passwordRepeat && password != '' && name != '' && login != '') {
      getIt<AuthBloc>().add(SetAuthEvent(
          user: User(
            userId: uuid.v4(),
            userName: name,
            userLogin: login,
            userPassword: password,
            userAuthorized: false
          )
        ));
    }
    else {
     
       setState(() {
        
      });
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
                Text(messageName),
                TextField(
                  onChanged: (value) {
                    login = value;
                  },
                  decoration: const InputDecoration(labelText: 'Логин'),
                ),
                Text(messageLogin),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Пароль',
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
                TextField(
                  onChanged: (value) {
                    passwordRepeat = value;
                  },
                  decoration: const InputDecoration(labelText: 'Повторите пароль'),
                ),
                Text(messagePass),
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