import 'package:flutter/material.dart';

import '../../utiles/side_bar_navigation_router.dart';

/// شاشة لوحة التحكم
class DashboardScreen extends StatelessWidget

    with AppShellRouterMixin
{
    DashboardScreen({super.key});

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
