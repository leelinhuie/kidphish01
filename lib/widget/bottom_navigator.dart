import 'package:flutter/material.dart';
import 'package:kidphish01/oldpages/home.dart';
import 'package:kidphish01/oldpages/lock.dart';
import 'package:kidphish01/user_profile/profile.dart';
import 'package:kidphish01/oldpages/report.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: 'Lock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Me',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(color: Colors.amber),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      backgroundColor: Colors.grey[800],
      onTap: (index) {
        onItemTapped(index); // Update selected index
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>Home()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AppListScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScreenTimePage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            break;
        }
      },
    );
  }
}
