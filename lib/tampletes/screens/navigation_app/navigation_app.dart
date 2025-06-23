import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';

/// شاشة اختبار التنقل
class NavigationApp extends StatelessWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
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
