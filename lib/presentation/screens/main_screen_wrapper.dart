import 'package:flutter/material.dart';

import '/presentation/screens/history/history_screen.dart';
import '/presentation/screens/home/home_screen.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  final _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            _pageController.animateToPage(
              index,
              duration: Duration(seconds: 1),
              curve: Curves.ease,
            );
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          HomeScreen(),
          HistoryScreen(),
        ],
      ),
    );
  }
}
