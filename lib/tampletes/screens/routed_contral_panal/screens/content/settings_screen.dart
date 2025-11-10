import 'package:flutter/material.dart';

/// شاشة الإعدادات
class SettingsScreen extends StatelessWidget

{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 80, color: Colors.orange),
          const SizedBox(height: 16),
          const Text('الإعدادات', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
