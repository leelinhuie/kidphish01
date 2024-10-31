import 'package:flutter/material.dart';
import 'package:kidphish01/model/modes_model.dart';
import 'package:installed_apps/app_info.dart';

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
        color: const Color(0xFF1F2A37), // Background color for the entire ListView
        padding: const EdgeInsets.all(20), // Add padding to the ListView
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
                    color: const Color(0xFF37474F), // Background color for each ListTile
                    margin: const EdgeInsets.symmetric(vertical: 4.0), // Optional spacing around items
                    child: ListTile(
                      title: Text(
                        app.name,
                        style: const TextStyle(color: Colors.white), // Set text color
                      ),
                      leading: app.icon != null
                          ? Image.memory(app.icon!)
                          : const Icon(Icons.android, color: Colors.white),
                      trailing: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: const Color.fromARGB(255, 255, 255, 255), // Color of unchecked checkbox
                        ),
                        child: Checkbox(
                          value: widget.modesModel.modeApps[widget.modesModel.getMode]?[app.packageName] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.modesModel.toggleAppSelection(app.packageName, value!);
                            });
                          },
                          activeColor: Colors.yellow, // Checkbox color
                          checkColor: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}