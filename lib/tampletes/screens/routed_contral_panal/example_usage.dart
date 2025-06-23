import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';

// Example of setting up the NavigationProvider
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    // Add your navigation items here
    // This can be done in initState or other appropriate places in your app
    if (navigationProvider.navigationItems.isEmpty) {
      _setupNavigationItems(navigationProvider);
    }

    return MaterialApp.router(
      title: 'Control Panel Example',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: navigationProvider.router,
    );
  }

  // Setup your navigation items
  void _setupNavigationItems(NavigationProvider provider) {
    // Example of adding navigation items
    provider.addNavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard,
      path: '/dashboard',
      page: const DashboardPage(),
    );

    provider.addNavigationItem(
      label: 'Users',
      icon: Icons.people,
      path: '/users',
      page: const UsersPage(),
    );

    provider.addNavigationItem(
      label: 'Settings',
      icon: Icons.settings,
      path: '/settings',
      page: const SettingsPage(),
    );

    // Set the logo and title
    provider.setLogo("assets/images/logo.png");
    provider.setTitle("Admin Control Panel");
  }
}

// Example pages
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dashboard Page'),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Users Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page'),
    );
  }
}
