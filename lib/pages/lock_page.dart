import 'package:flutter/material.dart';
import 'package:kidphish01/model/modes_model.dart';
import 'edit_mode_page.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  late ModesModel modesModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    modesModel = ModesModel([], {});
    fetchInstalledApps();
  }

  Future<void> fetchInstalledApps() async {
    await modesModel.fetchInstalledApps();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToEditMode(String mode) async {
    modesModel.setMode(mode);
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditModePage(modesModel: modesModel)),
    );
    if (result == true) {
      setState(() {}); // Rebuild LockPage to reflect changes
    }
  }

  void addMode() {
    // Add logic to add a new mode
    setState(() {
      modesModel.modes.add('New Mode');
      modesModel.modeApps['New Mode'] = {for (var app in modesModel.installedApps) app.packageName: false};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A37),
      appBar: AppBar(
        title: Text(
          'Lock',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1F2A37),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFF1F2A37), // Background color for the entire ListView
              padding: const EdgeInsets.all(20), // Add padding to the ListView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modes',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: modesModel.modes.length,
                      itemBuilder: (context, index) {
                        String mode = modesModel.modes[index];
                        return Container(
                          color: const Color(0xFF37474F), // Background color for each ListTile
                          margin: const EdgeInsets.symmetric(vertical: 4.0), // Optional spacing around items
                          child: ListTile(
                            title: Text(
                              mode,
                              style: const TextStyle(color: Colors.white), // Set text color
                            ),
                            trailing: Switch(
                              value: modesModel.mode == mode,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    modesModel.setMode(mode);
                                  }
                                });
                              },
                            ),
                            onTap: () => navigateToEditMode(mode),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addMode,
                    child: Text('Add Mode'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, // Button color
                      foregroundColor: Colors.black, // Text color
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}