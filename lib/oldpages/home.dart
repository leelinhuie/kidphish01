
// import 'package:flutter/material.dart';
// import 'package:kidphish01/widget/bottom_navigator.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;

//   void _onRunPressed() {
//     // Add functionality for the RUN button or the big icon button here
//     print('Run button pressed');
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1F2A37),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1F2A37),
//         title: Text('Home Page', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Big Icon Button
//             GestureDetector(
//               onTap: _onRunPressed,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.amber,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.play_arrow,
//                   size: 120,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // RUN Button
//             ElevatedButton(
//               onPressed: _onRunPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber, // Updated color parameter
//                 padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
//               ),
//               child: Text(
//                 'RUN',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }

