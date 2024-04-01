import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_events.dart';
import '../main.dart';

class AuthorizePage extends StatefulWidget {
  const AuthorizePage({super.key});

  @override
  State<AuthorizePage> createState() => _AuthorizePageState();
}

class _AuthorizePageState extends State<AuthorizePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getIt<AuthBloc>().add(RemoveAuthEvent());
            // getIt<AuthBloc>().add(GetAuthEvent());
            // setState(() {
            // });
          },
          child: const Text('Очистить регистрацию'),
        ),
      ),
    );
  }
}