import 'package:jodija_tamplites/tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
import 'package:flutter/material.dart';

/// شاشة التحليلات
class AnalyticsScreen extends StatelessWidget
with AppShellRouterMixin
{
    AnalyticsScreen({super.key
  
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text('التحليلات', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
