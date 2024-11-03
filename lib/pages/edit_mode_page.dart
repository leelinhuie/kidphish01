import 'package:flutter/material.dart';
import 'package:kidphish01/model/modes_model.dart';
import 'package:installed_apps/app_info.dart';
import 'package:kidphish01/pages/app_list.dart';

class EditModePage extends StatefulWidget {
  final ModesModel modesModel;

  const EditModePage({required this.modesModel, Key? key}) : super(key: key);

  @override
  _EditModePageState createState() => _EditModePageState();
}

class _EditModePageState extends State<EditModePage> {
  late TextEditingController _modeNameController;

  @override
  void initState() {
    super.initState();
    _modeNameController = TextEditingController(text: widget.modesModel.getMode);
  }

  @override
  void dispose() {
    _modeNameController.dispose();
    super.dispose();
  }

  void _updateModeName() {
    setState(() {
      String oldModeName = widget.modesModel.getMode;
      String newModeName = _modeNameController.text;
      widget.modesModel.updateModeName(oldModeName, newModeName);
    });
    Navigator.pop(context, true); // Notify LockPage of changes
  }

  void _navigateToAppListPage() {
    // Get the selected apps based on the current mode
    final selectedApps = widget.modesModel.installedApps.where((app) {
      return widget.modesModel.modeApps[widget.modesModel.getMode]?[app.packageName] ?? false;
    }).toList();

    // Navigate to AppListPage with the selected apps
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppListPage(selectedApps: selectedApps),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Mode',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1F2A37),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF1F2A37),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _modeNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mode Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
              onSubmitted: (_) => _updateModeName(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.modesModel.installedApps.length,
                itemBuilder: (context, index) {
                  AppInfo app = widget.modesModel.installedApps[index];
                  return Container(
                    color: const Color(0xFF37474F),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(
                        app.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: app.icon != null
                          ? Image.memory(app.icon!)
                          : const Icon(Icons.android, color: Colors.white),
                      trailing: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Checkbox(
                          value: widget.modesModel.modeApps[widget.modesModel.getMode]?[app.packageName] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.modesModel.toggleAppSelection(app.packageName, value!);
                            });
                          },
                          activeColor: Colors.yellow,
                          checkColor: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _navigateToAppListPage,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0), // Adjust padding to enlarge the button
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 20), // Set the font size for larger text
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Optional: make the button rounded
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}