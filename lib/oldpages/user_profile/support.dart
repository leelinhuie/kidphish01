import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Support",
            style: TextStyle(
              color: Colors.white, // Set title color
              fontWeight: FontWeight.bold,
            ),
          ),
        backgroundColor: Colors.grey[900], // Matches the page background color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set back arrow color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.support,
                  size: 50,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Email and Phone Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Email: xxxxx@gmail.com",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Phone: +601x-xxxxxxxx",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            // Cybersecurity and MCMC Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cybersecurity Malaysia:",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/cybersecurity.png', // Replace with actual path
                      height: 40,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "MCMC:",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/mcmc.png', // Replace with actual path
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
