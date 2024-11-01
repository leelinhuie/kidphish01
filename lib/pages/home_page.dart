import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _checkServiceStatus();
  }

  Future<void> _checkServiceStatus() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    setState(() {
      _isRunning = isRunning;
    });
  }

  void _onRunPressed() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();

    if (isRunning) {
      service.invoke("stopService");
    } else {
      service.startService();
    }

    setState(() {
      _isRunning = !isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 50, 60, 1),
      appBar: AppBar(
        title: Text(
          "KidPhish",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
        toolbarHeight: 200,
        backgroundColor: Color.fromRGBO(38, 50, 60, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Big Icon Button
            GestureDetector(
              onTap: _onRunPressed,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isRunning ? Icons.stop : Icons.play_arrow,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            // RUN Button
            ElevatedButton(
              onPressed: _onRunPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Updated color parameter
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              ),
              child: Text(
                _isRunning ? 'STOP' : 'RUN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
