import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/navigation_item.dart';
import '../screens/content_screens.dart';
import '../screens/side_tab_screen.dart';

/// مزود حالة التنقل الديناميكي باستخدام Provider
class NavigationProvider extends ChangeNotifier {
  // متغير لتتبع العلامة التبويب الحالية
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  // متغير لتتبع العنصر الجانبي المحدد
  int _currentSideIndex = 0;
  int get currentSideIndex => _currentSideIndex;
  NavigationProvider(List<NavigationItem> navigationItems) {
    // تهيئة القائمة بعناصر التنقل الممررة
    // تهيئة الراوتر عند إنشاء المزود
    _navigationItems.addAll(navigationItems);
  }

  // قائمة عناصر التنقل الديناميكية
  final List<NavigationItem> _navigationItems = [];

  // نسخة غير قابلة للتعديل من قائمة العناصر
  List<NavigationItem> get navigationItems =>
      List.unmodifiable(_navigationItems);

  // المسار الأولي
  String get initialRoute =>
      _navigationItems.isNotEmpty ? _navigationItems.first.path : '/';
  GoRouter createRouter() {
    return GoRouter(
      initialLocation: initialRoute,
      refreshListenable: this, // إعادة بناء الراوتر عند تغيير الحالة
      routes: [
        // إعادة توجيه للمسار الأساسي
        GoRoute(path: '/', redirect: (_, __) => initialRoute),

        // إنشاء المسارات بشكل ديناميكي من قائمة العناصر
        for (var i = 0; i < _navigationItems.length; i++)
          GoRoute(
            path: _navigationItems[i].path,
            pageBuilder: (context, state) {
              _currentTabIndex = i;
              _currentSideIndex = i;
              return CustomTransitionPage(
                key: state.pageKey,
                child: MainScreen(
                  sideIndex: i,
                  bodyWidget: _navigationItems[i].content,
                ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
      ],
    );
  }
}
