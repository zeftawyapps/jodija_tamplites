import 'package:JoDija_tamplites/tampletes/screens/navigation_app/screens/content_screens.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/sidebar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/sidebar_provider.dart';

/// تطبيق التنقل بالشريط الجانبي
class SidebarNavigationApp extends StatelessWidget {
  SidebarNavigationApp({super.key, this.sidebarItems});
  List<SidebarItem>? sidebarItems;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SidebarProvider(
        sidebarItems: sidebarItems ??
            [
              SidebarItem(
                path: '/dashboard',
                label: 'لوحة التحكم',
                icon: Icons.dashboard,
                content:
                    HomeContent(), // استبدال DashboardScreen بمحتوى الصفحة الرئيسية
              ),
              SidebarItem(
                path: '/profile',
                label: 'الملف الشخصي',
                icon: Icons.person,
                content:
                    ProfileContent(), // استبدال ProfileScreen بمحتوى الملف الشخصي
              ),
              SidebarItem(
                path: '/settings',
                label: 'الإعدادات',
                icon: Icons.settings,
                content: SettingsContent(),
              ),
            ],
      ),
      child: Builder(
        builder: (context) {
          final sidebarProvider = Provider.of<SidebarProvider>(context);
          return MaterialApp.router(
            title: 'تطبيق مع شريط جانبي',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            // استخدام GoRouter للتحكم في التنقل وتغيير الـ URL
            routerConfig: sidebarProvider.createRouter(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
