import 'dart:convert';
import 'dart:async'; // For TimeoutException
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRunning = false;
  final TextEditingController _urlController = TextEditingController();

  // Variables to manage loading state and result message
  bool _isLoading = false;
  String _result = '';

  @override
  void initState() {
    super.initState();
    _stopServiceIfRunning();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Request Notification Permission
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Request Location Permissions
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  Future<void> _stopServiceIfRunning() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("stopService");
      await Future.delayed(
          const Duration(seconds: 1)); // Wait for the service to stop
    }
    if (!mounted) return;
    setState(() => _isRunning = false);
    print('Background service stopped.');
  }

  void _toggleService() async {
    final service = FlutterBackgroundService();
    if (_isRunning) {
      service.invoke("stopService");
      print('Stopping background service.');
    } else {
      service.startService();
      print('Starting background service.');
    }
    if (!mounted) return;
    setState(() => _isRunning = !_isRunning);
  }

  /// Checks if the Flask server is reachable by hitting the /health endpoint.
  Future<bool> _checkServerConnection() async {
    try {
      print('Checking server connection...');
      final response = await http
          .get(Uri.parse(
              'http://10.0.2.2:8090/health')) // Use 10.0.2.2 for Android emulator
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Server connection successful: ${data['status']}');
        return data['status'] == 'ok';
      }
      print(
          'Server health check failed with status code: ${response.statusCode}');
      return false;
    } on TimeoutException catch (_) {
      // Catch TimeoutException first
      print('Request timed out while checking server connection.');
      return false;
    } on http.ClientException catch (e) {
      // Then catch ClientException
      print('ClientException while checking server connection: $e');
      return false;
    } catch (e) {
      // Finally, catch any other exceptions
      print('Unexpected error while checking server connection: $e');
      return false;
    }
  }

  /// Sends the entered URL to the server for checking.
  Future<void> _checkUrl() async {
    FocusScope.of(context).unfocus(); // Hide the keyboard
    if (_urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a URL to check.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String url = _urlController.text.trim();

    setState(() {
      _isLoading = true;
      _result = '';
    });

    print('Starting URL check for: $url');

    // Check server connection
    bool isConnected = await _checkServerConnection();
    if (!isConnected) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Cannot connect to the server. Please ensure it is running.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Send the URL to the server with a timeout
      var response = await http
          .post(
            Uri.parse(
                'http://10.0.2.2:8090/check_url'), // Update URL based on your environment
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'url': url}),
          )
          .timeout(const Duration(seconds: 10));

      print('Received response with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool isMalicious = data['is_malicious'];
        String message = data['message'];
        double probability = data['probability'];
        print('URL is malicious: $isMalicious');
        print('Probability: $probability');

        if (!mounted) return;
        setState(() {
          _result = message;
          _isLoading = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server error: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on TimeoutException catch (_) {
      // Catch TimeoutException first
      print('Request timed out while checking URL.');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request timed out. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    } on http.ClientException catch (e) {
      // Then catch ClientException
      print('ClientException while checking URL: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Client error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Finally, catch any other exceptions
      print('Unexpected error while checking URL: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(38, 50, 60, 1),
      appBar: AppBar(
        title: const Text(
          "KidPhish",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(38, 50, 60, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // URL Input Field
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  hintText: 'Enter URL to check',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _checkUrl(),
              ),
              const SizedBox(height: 20),
              // Check URL Button
              ElevatedButton(
                onPressed: _isLoading ? null : _checkUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Check URL',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
              ),
              const SizedBox(height: 20),
              // Display Result
              Text(
                _result,
                style: TextStyle(
                  fontSize: 24,
                  color:
                      _result.contains('malicious') ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleService,
        backgroundColor: Colors.amber,
        child: Icon(_isRunning ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
