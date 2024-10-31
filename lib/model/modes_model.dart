import 'package:kidphish01/model/apps_model.dart';
import 'package:installed_apps/app_info.dart';

class ModesModel extends AppsModel {
  String mode;
  int index = 0;
  List<String> modes = ["Parental Control", "Stranger Mode"]; // List of modes
  Map<String, Map<String, bool>> modeApps = {}; // Store apps for each mode

  ModesModel(List<AppInfo> installedApps, Map<String, bool> selectedApps, {this.mode = "Parental Control"})
      : super(installedApps, selectedApps) {
    for (var mode in modes) {
      modeApps[mode] = {for (var app in installedApps) app.packageName: false};
    }
  }

  String get getMode => mode;
  int get getIndex => index;

  void setMode(String newMode) {
    mode = newMode;
  }

  void toggleAppSelection(String packageName, bool isSelected) {
    modeApps[mode]![packageName] = isSelected;
  }

  void updateModeName(String oldModeName, String newModeName) {
    if (modes.contains(oldModeName) && !modes.contains(newModeName)) {
      int index = modes.indexOf(oldModeName);
      modes[index] = newModeName;
      modeApps[newModeName] = modeApps.remove(oldModeName)!;
      if (mode == oldModeName) {
        mode = newModeName;
      }
    }
  }
}