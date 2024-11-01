import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:kidphish01/oldpages/app_list.dart';
import 'dart:typed_data';
import 'package:kidphish01/widget/bottom_navigator.dart';


class AppListScreen extends StatefulWidget {
  @override
  _AppListScreenState createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  List<AppInfo> installedApps = [];
  Map<String, bool> selectedApps = {}; // Store app selection status
  bool isLoading = true;
  bool isKidsModeEnabled = false;
  bool isStrangerModeEnabled = false;
  bool isAppsSelected = true; // Track which mode is selected
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchInstalledApps();
  }

  Future<void> fetchInstalledApps() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
    setState(() {
      installedApps = apps;
      selectedApps = {for (var app in apps) app.packageName: false};
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleAppsModes(bool isAppMode) {
    setState(() {
      isAppsSelected = isAppMode;
    });
  }

  void _navigateToKidModeAppList() {
    List<AppInfo> kidModeApps = installedApps
        .where((app) => selectedApps[app.packageName] == true)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KidModeAppListScreen(selectedApps: kidModeApps),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A37),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2A37),
        title: Text('Lock', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleAppsModes(true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: isAppsSelected ? Colors.amber : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Apps',
                          style: TextStyle(
                            color: isAppsSelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleAppsModes(false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: isAppsSelected ? Colors.transparent : Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Modes',
                          style: TextStyle(
                            color: isAppsSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : isAppsSelected
                ? ListView.builder(
              itemCount: installedApps.length,
              itemBuilder: (context, index) {
                AppInfo app = installedApps[index];
                return ListTile(
                  leading: (app.icon != null && app.icon is Uint8List)
                      ? Image.memory(app.icon as Uint8List, width: 40, height: 40)
                      : Icon(Icons.android, size: 40, color: Colors.white), // Set default icon color to white
                  title: Text(
                    app.name ?? 'Unknown App',
                    style: TextStyle(color: Colors.white), // Set app name color to white
                  ),
                  subtitle: Text(
                    app.packageName,
                    style: TextStyle(color: Colors.grey), // Set package name color to grey for contrast
                  ),
                  trailing: Checkbox(
                    value: selectedApps[app.packageName],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedApps[app.packageName] = value ?? false;
                      });
                    },
                  ),
                  onTap: () {
                    InstalledApps.startApp(app.packageName);
                  },
                );

              },
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Kids Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: isKidsModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        isKidsModeEnabled = value;
                        if (value) {
                          _navigateToKidModeAppList();
                        }
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Stranger Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: isStrangerModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        isStrangerModeEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
