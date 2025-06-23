import 'package:JoDija_tamplites/tampletes/screens/navigation_app/screens/content_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/navigation_item.dart';
import 'providers/navigation_provider.dart';

/// شاشة اختبار التنقل
class NavigationApp extends StatelessWidget {
  NavigationApp({Key? key, this.navigationItems}) : super(key: key);
  List<NavigationItem>? navigationItems;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(navigationItems ??
          [
            NavigationItem(
              path: '/home',
              label: 'الرئيسية',
              icon: Icons.home,
              content: const HomeContent(),
            ),
            NavigationItem(
              path: '/profile',
              label: 'الملف الشخصي',
              icon: Icons.person,
              content: const ProfileContent(),
            ),
            NavigationItem(
              path: '/settings',
              label: 'الإعدادات',
              icon: Icons.settings,
              content: const SettingsContent(),
            ),
            NavigationItem(
              path: '/notifications',
              label: 'الإشعارات',
              icon: Icons.notifications,
              content: const NotificationsContent(),
            ),
            NavigationItem(
              path: '/messages',
              label: 'الرسائل',
              icon: Icons.message,
              content: const MessagesContent(),
            ),
          ]),
      child: Builder(
        builder: (context) {
          final navigationProvider = Provider.of<NavigationProvider>(context);
          return MaterialApp.router(
            title: 'اختبار التنقل',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            // استخدام GoRouter للتحكم في التنقل وتغيير الـ URL
            routerConfig: navigationProvider.createRouter(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
