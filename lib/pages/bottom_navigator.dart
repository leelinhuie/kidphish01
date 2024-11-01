import 'package:flutter/material.dart';
import 'package:kidphish01/pages/home_page.dart';
import 'package:kidphish01/pages/lock_page.dart';
import 'package:kidphish01/pages/report_pages.dart';
import 'package:kidphish01/pages/profile_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    LockPage(),
    ReportPages(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(38, 50, 56, 1),
        selectedItemColor: Color.fromRGBO(254, 211, 106, 1),
        unselectedItemColor: Color.fromRGBO(97, 125, 138, 1),
        currentIndex: _selectedIndex,
        onTap: _navigateTo,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: "Lock",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: "Report",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      )
    );
  }
}