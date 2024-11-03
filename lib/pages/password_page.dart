import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final String correctPassword = "1234"; // Set the correct password here
  String enteredPassword = "";

  void _addDigit(String digit) {
    setState(() {
      if (enteredPassword.length < 4) {
        enteredPassword += digit;
      }
      if (enteredPassword.length == 4) {
        _verifyPassword();
      }
    });
  }

  void _verifyPassword() {
    if (enteredPassword == correctPassword) {
      Navigator.pop(context, true); // Return true if password is correct
    } else {
      setState(() {
        enteredPassword = ""; // Clear the password if incorrect
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect password, try again")),
      );
    }
  }

  void _deleteLastDigit() {
    setState(() {
      if (enteredPassword.isNotEmpty) {
        enteredPassword = enteredPassword.substring(0, enteredPassword.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A37),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter Password",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Icon(
                index < enteredPassword.length ? Icons.circle : Icons.circle_outlined,
                color: Colors.white,
                size: 20,
              );
            }),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              if (index == 9) {
                return SizedBox.shrink(); // Empty space for alignment
              } else if (index == 10) {
                return _buildKey("0");
              } else if (index == 11) {
                return IconButton(
                  icon: Icon(Icons.backspace, color: Colors.white),
                  onPressed: _deleteLastDigit,
                );
              } else {
                return _buildKey((index + 1).toString());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String label) {
    return GestureDetector(
      onTap: () => _addDigit(label),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
