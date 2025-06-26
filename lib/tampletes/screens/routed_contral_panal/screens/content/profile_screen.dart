import 'package:flutter/material.dart';

/// شاشة الملف الشخصي
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.green),
          const SizedBox(height: 16),
          const Text('الملف الشخصي', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
