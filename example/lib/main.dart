import 'package:flutter/material.dart';
import 'package:jodija_tamplites/jodija_tamplites.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      titleApp: 'JoDija Templates Example',
      initRouter: '/dashboard',
      languageCode: 'en',
      isDarkMode: false,
      loclizationLangs: const {},
      sidebarItems: [
        RouteItem(
          id: 'dashboard',
          path: '/dashboard',
          label: 'Dashboard',
          icon: Icons.dashboard_outlined,
          content: const Center(child: Text('Dashboard Screen')),
          isSideBarRouted: true,
          isAppBar: true,
        ),
        RouteItem(
          id: 'settings',
          path: '/settings',
          label: 'Settings',
          icon: Icons.settings_outlined,
          content: const Center(child: Text('Settings Screen')),
          isSideBarRouted: true,
          isAppBar: true,
        ),
      ],
    );
  }
}
