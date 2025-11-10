import 'package:flutter/material.dart';

import '../../utiles/side_bar_navigation_router.dart';

/// شاشة التحليلات
class ErrorScreen extends StatelessWidget
    with SideBarNavigationRouterMixin

{
    ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          const Text('404', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
