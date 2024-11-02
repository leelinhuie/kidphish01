import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRunning = false;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stopServiceIfRunning();
  }

  Future<void> _stopServiceIfRunning() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("stopService");
    }
    setState(() => _isRunning = false);
  }

  void _toggleService() async {
    final service = FlutterBackgroundService();
    if (_isRunning) {
      service.invoke("stopService");
    } else {
      service.startService();
    }
    setState(() => _isRunning = !_isRunning);
  }

  void _checkUrl() {
    if (_urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a URL to check.'), backgroundColor: Colors.red),
      );
    } else {
      print('Checking URL: ${_urlController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(38, 50, 60, 1),
      appBar: AppBar(
        title: const Text("KidPhish", style: TextStyle(color: Colors.white, fontSize: 40)),
        centerTitle: true,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(38, 50, 60, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toggleService,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                child: Icon(
                  _isRunning ? Icons.stop : Icons.play_arrow,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleService,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              ),
              child: Text(
                _isRunning ? 'STOP' : 'RUN',
                style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  hintText: 'Enter URL to check',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? _checkUrl : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Check URL', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
