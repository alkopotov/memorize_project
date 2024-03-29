import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Выбери игру'),
      ),
      body:  const Center(
        child: Text('Cписок игр'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Учить',
            icon: Icon(Icons.school)
          ),
          BottomNavigationBarItem(
            label: 'Добавить',
            icon: Icon(Icons.edit)
          ),
          BottomNavigationBarItem(
            label: 'Профиль',
            icon: Icon(Icons.person)
          ),
        ]),
    );
  }
}
