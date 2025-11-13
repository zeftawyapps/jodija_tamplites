import 'package:flutter/material.dart';

import '../../utiles/side_bar_navigation_router.dart';

/// شاشة مخصصة للعناصر المضافة
class CustomContentScreen extends StatelessWidget

    with AppShellRouterMixin
{
  final String title;

    CustomContentScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.extension, size: 80, color: Colors.teal),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          const Text('محتوى مخصص تم إضافته ديناميكيًا'),
        ],
      ),
    );
  }
}
