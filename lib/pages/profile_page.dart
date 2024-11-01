import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidphish01/pages/change_password.dart';
import 'package:kidphish01/pages/support.dart';
// Removed the import for bottom_navigator.dart
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // Stores the selected image

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Set the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: ProfileContent(
        profileImage: _profileImage,
        onImageChange: _pickImage, // Pass the image picker function
      ),
      // Removed the bottom navigation bar
    );
  }
}

class ProfileContent extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onImageChange;

  ProfileContent({required this.profileImage, required this.onImageChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
          onTap: onImageChange, // Trigger image picker on tap
          child: CircleAvatar(
            radius: 50,
            backgroundImage: profileImage != null
                ? FileImage(profileImage!) // Display selected image if available
                : AssetImage('lib/assets/images/profile.jpg') as ImageProvider, // Default image
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: Icon(Icons.camera_alt, size: 15, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Me",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 20),
        ProfileOption(
          icon: Icons.person,
          label: "xxxxxxxxxx",
          editable: true,
          onTap: () {
            // Define your navigation action here for profile edit, if needed
          },
        ),
        ProfileOption(
          icon: Icons.email,
          label: "xxxxxxxx@gmail.com",
          editable: true,
          onTap: () {
            // Define your navigation action here for email edit, if needed
          },
        ),
        ProfileOption(
          icon: Icons.lock,
          label: "Change Password",
          editable: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordPage()),
            );
          },
        ),
        ProfileOption(
          icon: Icons.support,
          label: "Support",
          editable: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportScreen()),
            );
          },
        ),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool editable;
  final VoidCallback onTap;

  ProfileOption({
    required this.icon,
    required this.label,
    this.editable = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              if (editable) Icon(Icons.edit, color: Colors.white),
              if (!editable)
                Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
