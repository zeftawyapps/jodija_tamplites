import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/route_item.dart';
import '../screens/content/error_screen.dart';
import '../screens/main_screen.dart';

/// App Shell Router Provider - manages routing and navigation state
class AppShellRouterProvider extends ChangeNotifier {
  AppShellRouterProvider({required this.sidebarItems, this.errorConent}) {
    this.sidebarItems = sidebarItems;
  }

  List<RouteItem> sidebarItems;

  void setSidebarItems(List<RouteItem> items) {
    sidebarItems = items;
    // createRouter(_initR);
    notifyListeners();
  }

  Widget? errorConent;
  int selectedIndex = 0;
  int selectBottomNavIndex = 0;
  bool isAppInit = true;
  void setSelectedIndex(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    notifyListeners();
  }

  void setSelectBottomNavIndex(int index) {
    selectBottomNavIndex = index;
    notifyListeners();
  }

  // إعادة إنشاء الراوتر لإشعار المستمعين بالتغيير في العناصر
  void recreateRouter() {
    // مجرد إشعار بالتغييرات ليتم إعادة بناء الراوتر من خلال refreshListenable
    notifyListeners();
  }

// add current  sidebar items
  RouteItem getCurrentSidebarItems() {
    return sidebarItems[selectedIndex];
  }

  // إيجاد فهرس العنصر بناء على المسار
  int _getIndexForPath(String path) {
    for (int i = 0; i < sidebarItems.length; i++) {
      if (sidebarItems[i].path == path) {
        return i;
      }
    }

    for (int i = 0; i < sidebarItems.length; i++) {
      String pathI = sidebarItems[i].path;
      int paramId = pathI.indexOf(':');

      int cutter = 0;
      int queryId = pathI.indexOf('?');
      if (queryId > 0) {
        if (paramId > 0) {
          cutter = paramId < queryId ? paramId : queryId;
        }
      } else if (paramId > 0) {
        cutter = paramId;
      }
      if (cutter > 0) {
        String baseUrl = pathI.substring(0, cutter);
        if (path.contains(baseUrl)) {
          return i;
        }
      }
    }

    for (int i = 0; i < sidebarItems.length; i++) {
      if (sidebarItems[i].path == "/error") {
        return i;
      }
    }

    return 0; // العودة إلى عنصر لوحة التحكم في حال عدم وجود المسار
  }

  // التعامل مع النقر على عناصر الشريط الجانبي
  void handleItemTap(BuildContext context, RouteItem item, int index) {
    isAppInit = false;
    if (item.isSideBarRouted && item.path != null) {
      // التعامل مع العناصر المسارة
      setSelectedIndex(index);
      context.go(item.path!);
    } else {
      // // التعامل مع العناصر غير المسارة
      // if (item.onTap != null) {
      //   item.onTap!();
      // } else {
      //   // عرض المحتوى كنافذة منبثقة
      //   _showNonRoutedContent(context, item);
      // }
    }
  }

  void handleItemTapByPath(BuildContext context, String path) {
    isAppInit = false;
    int index = _getIndexForPath(path);
    RouteItem item = sidebarItems[index];

    if (item.isSideBarRouted && item.path != null) {
      // التعامل مع العناصر المسارة
      setSelectedIndex(index);
      context.go(item.path!);
    } else {
      // التعامل مع العناصر غير المسارة
    }
    // if (item.onTap != null) {
    //       item.onTap!();
    //     }
    // if (item.openWithDailog) {
    //       _showNonRoutedContent(context, item);

    //     }
  }

  // عرض المحتوى غير المسار
  void _showNonRoutedContent(BuildContext context, RouteItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item.label),
          content: SizedBox(
            width: double.maxFinite,
            child: item.content,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  // // تسجيل الخروج
  // void logout(BuildContext context, AuthProvider authProvider) {
  //   authProvider.logout();
  //   context.go('/login');
  // }
  String? _initR;
  GoRouter createRouter(String? initRouter,
      {List<NavigatorObserver>? observers}) {
    _initR = initRouter ?? '';
    String initR;
    if (initRouter != null) {
      initR = initRouter;
    } else {
      initR = sidebarItems.isNotEmpty ? sidebarItems[0].path : '/';
    }
    RouteItem error = RouteItem(
      id: 'error',
      path: '/error',
      label: 'error',
      icon: Icons.dashboard,
      content: errorConent ?? ErrorScreen(),
      isSideBarRouted: false,
    );

    sidebarItems.add(error);

    return GoRouter(
      observers: observers,
      initialLocation: !isAppInit
          ? sidebarItems[selectedIndex].path
          : sidebarItems[_getIndexForPath(initR)].path,

      // initialLocation: initR,
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
              final item = sidebarItems[i];

              // 1. تحديث الفهرس المختار مباشرة (أداء أفضل من البحث بالمسار)
              selectedIndex = i;

              // 2. مزامنة بيانات المسار مع الـ Mixin
              if (item.content is AppShellRouterMixin) {
                final mixin = item.content as AppShellRouterMixin;

                // تعيين المسار الرئيسي
                mixin.mainPath = item.path;

                // تحديث معاملات المسار (Params) - مثل :id
                item.prams?.forEach((key, _) {
                  if (state.pathParameters.containsKey(key)) {
                    item.prams![key] = state.pathParameters[key];
                  }
                });
                mixin.params = item.prams;

                // تحديث معاملات الاستعلام (Query) - مثل ?search=text
                item.queryParameters?.forEach((key, _) {
                  final queryVal = state.uri.queryParameters[key];
                  if (queryVal != null) {
                    item.queryParameters![key] = queryVal;
                  }
                });
                mixin.query = item.queryParameters;
              }

              return CustomTransitionPage(
                key: state.pageKey,
                child: MainScreen(
                  routeItem: sidebarItems[i],
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
        // match the path with params and query
        final matchedPathWithParams = sidebarItems.any(
          (item) {
            if (item.path == null) return false;
            final uri = Uri.parse(state.matchedLocation);
            final itemUri = Uri.parse(item.path!);
            if (uri.pathSegments.length != itemUri.pathSegments.length) {
              return false;
            }
            for (int i = 0; i < itemUri.pathSegments.length; i++) {
              final itemSegment = itemUri.pathSegments[i];
              final uriSegment = uri.pathSegments[i];
              if (itemSegment.startsWith(':')) {
                continue; // هذا جزء من المعاملات
              }
              if (itemSegment != uriSegment) {
                return false;
              }
            }
            return true;
          },
        );
        if (matchedPathWithParams) {
          return null;
        }

        // إذا كان المسار غير موجود، عد إلى لوحة التحكم
        if (!matchedPath && state.matchedLocation != '/') {
          return '/error';
        }
        return null;
      },
    );
  }
}
