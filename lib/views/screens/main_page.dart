import 'package:flutter/material.dart';
import 'package:todo_app/views/screens/pages/home_page.dart';
import 'package:todo_app/views/screens/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        items: bottomBarItem,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
      ),
    );
  }

  List<Widget> pages = [
    HomePage(),
    SettingsPage(),
  ];

  List<BottomNavigationBarItem> bottomBarItem = [
    BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: "Setting",
      icon: Icon(Icons.settings),
    ),
  ];
}
