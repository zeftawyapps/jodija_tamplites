import 'package:flutter/material.dart';

/// شاشة لوحة التحكم
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard, size: 80, color: Colors.blue),
          const SizedBox(height: 16),
          const Text('لوحة التحكم', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
