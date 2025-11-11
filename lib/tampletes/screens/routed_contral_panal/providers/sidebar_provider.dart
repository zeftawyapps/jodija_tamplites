import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/route_item.dart';
import '../screens/content/error_screen.dart';
import '../screens/main_screen.dart';

/// مزود حالة الشريط الجانبي
class SidebarProvider extends ChangeNotifier {
  SidebarProvider({required this.sidebarItems, this.errorConent}) {
    this.sidebarItems = sidebarItems;
  }

  List<RouteItem> sidebarItems;
  Widget? errorConent;
  int selectedIndex = 0;
  bool isAppInit = true;
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

    if (item.isSideBarRouted && item.resolvedPath != null) {
      // التعامل مع العناصر المسارة
      print(item.resolvedPath);
      context.go(item.resolvedPath);
      setSelectedIndex(index);
      item.isCalledFromSideBar = true;
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

  /// تحديد المسار الابتدائي للراوتر
  String _getInitialRoute(String? initRouter) {
    if (initRouter != null) {
      return initRouter;
    }
    return sidebarItems.isNotEmpty ? sidebarItems[0].resolvedPath : '/';
  }

  /// إضافة صفحة الخطأ إلى قائمة العناصر
  void _addErrorRoute() {
    RouteItem error = RouteItem(
      path: '/error',
      label: 'error',
      icon: Icons.dashboard,
      content: errorConent ?? ErrorScreen(),
      isSideBarRouted: false,
    );
    sidebarItems.add(error);
  }

  /// تحديد موقع البداية للراوتر
  String _getInitialLocation(String initRoute) {
    if (!isAppInit) {
      return sidebarItems[selectedIndex].path;
    }
    return sidebarItems[_getIndexForPath(initRoute)].path;
  }

  /// معالجة parameters من URL ووضعها في RouteItem
  void _handlePathParameters(GoRouterState state) {
    Map<String, dynamic>? params =
        sidebarItems[selectedIndex].prams != null
            ? Map<String, dynamic>.from(sidebarItems[selectedIndex].prams!)
            : null;

    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        if (state.pathParameters.containsKey(key)) {
          params[key] = state.pathParameters[key];
        }
      });
      
      // تحديث prams بالقيم الجديدة
      sidebarItems[selectedIndex].prams = params;
      
      // تمرير params إلى المحتوى إذا كان يدعم ذلك
      if (sidebarItems[selectedIndex].content is SideBarNavigationRouterMixin) {
        SideBarNavigationRouterMixin sidebarMixin =
            sidebarItems[selectedIndex].content as SideBarNavigationRouterMixin;
        sidebarMixin.params = params;
      }
    }
  }

  /// معالجة query parameters من URL ووضعها في RouteItem
  void _handleQueryParameters(GoRouterState state) {
    Map<String, dynamic>? query = sidebarItems[selectedIndex].queryParameters;
    
    if (query != null && query.isNotEmpty) {
      query.forEach((key, value) {
        if (state.uri.queryParameters[key] != null) {
          query[key] = state.uri.queryParameters[key];
        }
      });
      
      // تمرير query إلى المحتوى إذا كان يدعم ذلك
      if (sidebarItems[selectedIndex].content is SideBarNavigationRouterMixin) {
        SideBarNavigationRouterMixin sidebarMixin =
            sidebarItems[selectedIndex].content as SideBarNavigationRouterMixin;
        sidebarMixin.query = query;
      }
    }
  }

  /// إنشاء صفحة بانتقال مخصص
  CustomTransitionPage _buildPage(GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: MainScreen(
        contentWidget: sidebarItems[selectedIndex].content,
        isRouteInsidebar: sidebarItems[selectedIndex].isSideBarRouted,
        isAppBar: sidebarItems[selectedIndex].isAppBar,
        appBarTitl: sidebarItems[selectedIndex].label,
        isDrawerShow: sidebarItems[selectedIndex].isDrawerShow,
        isAppBarLargeScreenShowTitle:
            sidebarItems[selectedIndex].isDesplayTitleInLargScreen,
        isAppBarSmallScreenShowTitle:
            sidebarItems[selectedIndex].isDesplayTitleInSmallScreen,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// التحقق من تطابق المسار مع parameters
  bool _matchPathWithParams(RouteItem item, String location) {
    if (item.path == null) return false;
    
    final uri = Uri.parse(location);
    final itemUri = Uri.parse(item.path!);
    
    if (uri.pathSegments.length != itemUri.pathSegments.length) {
      return false;
    }
    
    for (int i = 0; i < itemUri.pathSegments.length; i++) {
      final itemSegment = itemUri.pathSegments[i];
      final uriSegment = uri.pathSegments[i];
      
      // تخطي المعاملات (تبدأ بـ :)
      if (itemSegment.startsWith(':')) {
        continue;
      }
      
      if (itemSegment != uriSegment) {
        return false;
      }
    }
    
    return true;
  }

  /// معالجة إعادة التوجيه للمسارات غير الموجودة
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    // التأكد من وجود المسار في العناصر
    final matchedPath = sidebarItems.any(
      (item) => item.path == state.matchedLocation,
    );
    
    // التحقق من تطابق المسار مع params
    final matchedPathWithParams = sidebarItems.any(
      (item) => _matchPathWithParams(item, state.matchedLocation),
    );
    
    if (matchedPathWithParams) {
      return null;
    }

    // إذا كان المسار غير موجود، عد إلى صفحة الخطأ
    if (!matchedPath && state.matchedLocation != '/') {
      return '/error';
    }
    
    return null;
  }

  /// إنشاء GoRouter بكامل الإعدادات
  GoRouter createRouter(String? initRouter) {
    // تحديد المسار الابتدائي
    String initRoute = _getInitialRoute(initRouter);
    
    // إضافة صفحة الخطأ
    _addErrorRoute();

    return GoRouter(
      initialLocation: _getInitialLocation(initRoute),
      refreshListenable: this,
      routes: [
        // المسار الرئيسي - إعادة التوجيه إلى المسار الابتدائي
        GoRoute(
          path: "/",
          redirect: (context, state) => initRoute,
        ),

        // إنشاء مسارات لكل عناصر الشريط الجانبي
        for (var i = 0; i < sidebarItems.length; i++)
          GoRoute(
            path: sidebarItems[i].path!,
            pageBuilder: (context, state) {
              // تحديث المؤشر المحدد بناء على المسار
              selectedIndex = _getIndexForPath(state.matchedLocation);
              
              // التحقق إذا تم الاستدعاء من الـ sidebar وتعيين الرابط الأساسي
              if (sidebarItems[selectedIndex].isCalledFromSideBar) {
                // إعادة تعيين الـ flag بعد الاستخدام
                sidebarItems[selectedIndex].isCalledFromSideBar = false;
                
                // تمرير الرابط الرئيسي إلى المحتوى إذا كان يدعم ذلك
                if (sidebarItems[selectedIndex].content is SideBarNavigationRouterMixin) {
                  SideBarNavigationRouterMixin sidebarMixin =
                      sidebarItems[selectedIndex].content as SideBarNavigationRouterMixin;
                  sidebarMixin.mainPath = sidebarItems[selectedIndex].path;
                }
              }
              
              // معالجة path parameters
              _handlePathParameters(state);
              
              // معالجة query parameters
              _handleQueryParameters(state);

              // إنشاء الصفحة
              return _buildPage(state);
            },
          ),
      ],
      redirect: _handleRedirect,
    );
  }
}