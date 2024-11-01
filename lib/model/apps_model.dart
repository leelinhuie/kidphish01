import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';

class AppsModel {
  List<AppInfo> installedApps = [];
  Map<String, bool> selectedApps = {}; // Store app selection status

  AppsModel(this.installedApps, this.selectedApps);

  List<AppInfo> get getInstalledApps => installedApps; // getter for installedApps
  Map<String, bool> get getSelectedApps => selectedApps;

  // fetches the installed apps and updates the installedApps and selectedApps
  Future<void> fetchInstalledApps() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
    installedApps = apps;
    selectedApps = {for (var app in apps) app.packageName: false};
  }
}
/*
below are information about the class AppInfo
class AppInfo {
  String name;
  Uint8List? icon;
  String packageName;
  String versionName;
  int versionCode;
  BuiltWith builtWith;
  int installedTimestamp;
}

The map
*/ 