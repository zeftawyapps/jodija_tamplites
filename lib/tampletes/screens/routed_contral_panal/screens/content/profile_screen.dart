import 'package:flutter/material.dart';

import '../../utiles/side_bar_navigation_router.dart';

/// شاشة الملف الشخصي
class ProfileScreen extends StatelessWidget
with SideBarNavigationRouterMixin
{
    ProfileScreen({super.key});

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
