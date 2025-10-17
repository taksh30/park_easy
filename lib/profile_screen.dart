import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF1976D2),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF1976D2),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'john.doe@email.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 30),
          _buildProfileItem(Icons.payment, 'Payment Methods', () {}),
          _buildProfileItem(Icons.history, 'Parking History', () {}),
          _buildProfileItem(Icons.favorite, 'Favorite Spots', () {}),
          _buildProfileItem(Icons.settings, 'Settings', () {}),
          _buildProfileItem(Icons.help, 'Help & Support', () {}),
          _buildProfileItem(Icons.info, 'About', () {}),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF1976D2)),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
