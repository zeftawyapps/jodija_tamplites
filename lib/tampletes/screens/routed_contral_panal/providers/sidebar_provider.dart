import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/sidebar_item.dart';
import '../screens/main_screen.dart';

/// مزود حالة الشريط الجانبي
class SidebarProvider extends ChangeNotifier {
  SidebarProvider({required this.sidebarItems}) {
    this.sidebarItems = sidebarItems;
  }

  List<SidebarItem> sidebarItems;

  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    notifyListeners();
  }

  // إعادة إنشاء الراوتر لإشعار المستمعين بالتغيير في العناصر
  void recreateRouter() {
    // مجرد إشعار بالتغييرات ليتم إعادة بناء الراوتر من خلال refreshListenable
    notifyListeners();
  }

  // إيجاد فهرس العنصر بناء على المسار
  int _getIndexForPath(String path) {
    for (int i = 0; i < sidebarItems.length; i++) {
      if (sidebarItems[i].path == path) {
        return i;
      }
    }
    return 0; // العودة إلى عنصر لوحة التحكم في حال عدم وجود المسار
  }

  // إنشاء GoRouter مع تحديث مستمر للمسارات
  GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/dashboard',
      routes: [
        // المسار الرئيسي - إعادة التوجيه إلى لوحة التحكم
        GoRoute(path: '/', redirect: (_, __) => '/dashboard'),
        // إنشاء مسارات لكل عناصر الشريط الجانبي
        for (var i = 0; i < sidebarItems.length; i++)
          GoRoute(
            path: sidebarItems[i].path,
            pageBuilder: (context, state) {
              // تحديث المؤشر المحدد بناء على المسار
              final currentPath = state.matchedLocation;
              selectedIndex = _getIndexForPath(currentPath);

              return CustomTransitionPage(
                key: state.pageKey,
                child: MainScreen(
                  contentWidget: sidebarItems[selectedIndex].content,
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
      // تحديث المسارات عند تغيير العناصر
      refreshListenable: this,
      // استعادة المسار المفضل بناءً على الحالة
      redirect: (context, state) {
        // التأكد من وجود المسار في العناصر
        final matchedPath = sidebarItems.any(
          (item) => item.path == state.matchedLocation,
        );

        // إذا كان المسار غير موجود، عد إلى لوحة التحكم
        if (!matchedPath && state.matchedLocation != '/') {
          return '/dashboard';
        }
        return null;
      },
    );
  }
}
