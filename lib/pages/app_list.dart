import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'dart:typed_data';
import 'password_page.dart';

class AppListPage extends StatelessWidget {
  final List<AppInfo> selectedApps;

  AppListPage({Key? key, required this.selectedApps}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context) async {
    // Navigate to the PasswordPage when back button is pressed
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordPage()),
    );
    // If password was entered correctly, allow going back
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('App List'),
          backgroundColor: Color(0xFF1F2A37),
          foregroundColor: Colors.white,
        ),
        backgroundColor: Color(0xFF1F2A37),
        body: selectedApps.isNotEmpty
            ? ListView.builder(
          itemCount: selectedApps.length,
          itemBuilder: (context, index) {
            AppInfo app = selectedApps[index];
            return ListTile(
              leading: app.icon != null
                  ? Image.memory(app.icon as Uint8List, width: 40, height: 40)
                  : Icon(Icons.android, size: 40, color: Colors.white),
              title: Text(
                app.name ?? 'Unknown App',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(app.packageName, style: TextStyle(color: Colors.grey)),
              onTap: () async {
                // Try to start the app
                try {
                  await InstalledApps.startApp(app.packageName);
                } catch (e) {
                  // Handle the case where the app cannot be opened
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Could not open ${app.name}")),
                  );
                }
              },
            );
          },
        )
            : Center(
          child: Text(
            'No apps selected',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
