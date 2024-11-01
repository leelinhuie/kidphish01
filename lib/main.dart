import 'package:flutter/material.dart';
import 'package:kidphish01/pages/bottom_navigator.dart';
import 'package:kidphish01/pages/home_page.dart';
import 'package:kidphish01/pages/lock_page.dart';
import 'package:kidphish01/pages/report_pages.dart';
import 'package:kidphish01/pages/profile_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kidphish01/services/background_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  await Permission.location.isDenied.then(
    (value) {
      if (value) {
        Permission.location.request();
      }
    },
  );
  await initializeService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigator(),
      routes: {
        '/homePage': (context) => HomePage(),
        '/lock': (context) => LockPage(),
        '/report': (context) => ReportPages(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}