
// import 'package:flutter/material.dart';
// import 'package:installed_apps/app_info.dart';
// import 'dart:typed_data';

// class KidModeAppListScreen extends StatelessWidget {
//   final List<AppInfo> selectedApps;

//   KidModeAppListScreen({Key? key, required this.selectedApps}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kid Mode App List'),
//         backgroundColor: Color(0xFF1F2A37),
//         foregroundColor: Colors.white, // Sets back arrow and title to white
//       ),
//       backgroundColor: Color(0xFF1F2A37),
//       body: selectedApps.isNotEmpty
//           ? ListView.builder(
//         itemCount: selectedApps.length,
//         itemBuilder: (context, index) {
//           AppInfo app = selectedApps[index];
//           return ListTile(
//             leading: app.icon != null
//                 ? Image.memory(app.icon as Uint8List, width: 40, height: 40)
//                 : Icon(Icons.android, size: 40, color: Colors.white),
//             title: Text(app.name ?? 'Unknown App', style: TextStyle(color: Colors.white)),
//             subtitle: Text(app.packageName, style: TextStyle(color: Colors.grey)),
//           );
//         },
//       )
//           : Center(
//         child: Text(
//           'No apps selected for Kid Mode',
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

