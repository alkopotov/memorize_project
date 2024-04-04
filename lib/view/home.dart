import 'package:flutter/material.dart';
import 'package:memorize/view/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    const Text('Cписок игр'),
    const Text('Добавить'),
    const ProfilePage(),
  ];

  List<String> titles = [
    'Учить слова',
    'Редактирование списка слов',
    'Профиль',
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[_selectedIndex]),
      ),
      body:  pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
        ],
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }
}
