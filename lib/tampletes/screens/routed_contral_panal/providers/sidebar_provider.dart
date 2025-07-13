import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/route_item.dart';
import '../screens/main_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import 'auth_provider.dart';

/// مزود حالة الشريط الجانبي
class SidebarProvider extends ChangeNotifier {
  SidebarProvider({required this.sidebarItems}) {
    this.sidebarItems = sidebarItems;
  }

  List<RouteItem> sidebarItems;

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
      if (sidebarItems[i].isSideBarRouted && sidebarItems[i].path == path) {
        return i;
      }
    }
    return 0; // العودة إلى عنصر لوحة التحكم في حال عدم وجود المسار
  }

  // التعامل مع النقر على عناصر الشريط الجانبي
  void handleItemTap(BuildContext context, RouteItem item, int index) {
    if (item.isSideBarRouted && item.path != null) {
      // التعامل مع العناصر المسارة
      setSelectedIndex(index);
      context.go(item.path!);
    } else {
      // التعامل مع العناصر غير المسارة
      if (item.onTap != null) {
        item.onTap!();
      } else {
        // عرض المحتوى كنافذة منبثقة
        _showNonRoutedContent(context, item);
      }
    }
  }

  // عرض المحتوى غير المسار
  void _showNonRoutedContent(BuildContext context, RouteItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(item.icon),
            const SizedBox(width: 8),
            Text(item.label),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          child: item.content,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  // // تسجيل الخروج
  // void logout(BuildContext context, AuthProvider authProvider) {
  //   authProvider.logout();
  //   context.go('/login');
  // }

  GoRouter createRouter(String? initRouter) {
    String initR;
    if (initRouter != null) {
      initR = initRouter;
    } else {
      initR = sidebarItems.isNotEmpty ? sidebarItems[0].path : '/';
    }

    return GoRouter(
      initialLocation: sidebarItems[selectedIndex].path ?? '/',
      routes: [
        // المسار الرئيسي - إعادة التوجيه إلى لوحة التحكم
        GoRoute(
            path: "/",
            redirect: (context, state) {
              return initR;
            }),

        // إنشاء مسارات لكل عناصر الشريط الجانبي
        for (var i = 0; i < sidebarItems.length; i++)
          GoRoute(
            path: sidebarItems[i].path!,
            pageBuilder: (context, state) {
              // تحديث المؤشر المحدد بناء على المسار
              final currentPath = state.matchedLocation;
              selectedIndex = _getIndexForPath(currentPath);

              return CustomTransitionPage(
                key: state.pageKey,
                child: MainScreen(
                  contentWidget: sidebarItems[selectedIndex].content,
                  isRouteInsidebar: sidebarItems[selectedIndex].isSideBarRouted,
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
