// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kidphish01/widget/bottom_navigator.dart';

// class ScreenTimePage extends StatefulWidget {
//   @override
//   _ScreenTimePageState createState() => _ScreenTimePageState();
// }

// class _ScreenTimePageState extends State<ScreenTimePage> {
//   static const platform = MethodChannel('com.example.app/usageStats');
//   int _selectedIndex = 2; // Set default selected index to 2 for this page

//   // Holds the usage data
//   List<Map<String, dynamic>> appUsageData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAppUsageData();
//   }

//   Future<void> fetchAppUsageData() async {
//     try {
//       final List<dynamic> usageData = await platform.invokeMethod('getUsageStats');
//       setState(() {
//         appUsageData = usageData.map((e) => Map<String, dynamic>.from(e)).toList();
//       });
//     } on PlatformException catch (e) {
//       print("Failed to get usage data: ${e.message}");
//     }
//   }

//   String formatDuration(int seconds) {
//     final hours = (seconds ~/ 3600);
//     final minutes = ((seconds % 3600) ~/ 60);
//     return '${hours}h ${minutes}m';
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // Add navigation logic based on the index if needed
//     // Navigator.push or other logic to go to different pages
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Report"),
//       ),
//       body: ListView.builder(
//         itemCount: appUsageData.length,
//         itemBuilder: (context, index) {
//           final app = appUsageData[index];
//           return ListTile(
//             leading: Icon(Icons.apps),
//             title: Text(app['appName']),
//             subtitle: Text("Screen time: ${formatDuration(app['screenTime'])}"),
//           );
//         },
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }
