import 'package:flutter/material.dart';

import '/screens/history/history_screen.dart';
import '/screens/home/home_screen.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
            tooltip: 'History',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
