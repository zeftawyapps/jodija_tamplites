import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final String path;
  final Widget page;

  NavigationItem({
    required this.label,
    required this.icon,
    required this.path,
    required this.page,
  });
}

class NavigationProvider with ChangeNotifier {
  int selectedIndex = 0;
  String currentPath = '/';
  int hoverIndex = 0;
  final List<NavigationItem> _navigationItems = [];
  int _currentIndex = 0;
  String _logo = "null";
  String _title = "Control Panel";
  late GoRouter _router;

  NavigationProvider() {
    _initializeRouter();
  }

  List<NavigationItem> get navigationItems => _navigationItems;
  int get currentIndex => _currentIndex;
  String get logo => _logo;
  String get title => _title;
  GoRouter get router => _router;

  void setLogo(String logo) {
    _logo = logo;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  String getTitle() {
    return _title;
  }

  void _initializeRouter() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        // Default route if no navigation items are added
        GoRoute(
          path: '/',
          builder: (context, state) => const Center(
            child: Text('Add navigation items to see content here'),
          ),
        ),
        // Dynamic routes will be added when navigation items are added
      ],
    );
  }

  void setCurrentIndex(int index) {
    if (index >= 0 && index < _navigationItems.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void updateRoutes() {
    final List<RouteBase> routes = [
      // Default route
      GoRoute(
        path: '/',
        builder: (context, state) => _navigationItems.isNotEmpty
            ? _navigationItems[0].page
            : const Center(
                child: Text('Add navigation items to see content here'),
              ),
      ),
    ];

    // Add routes for each navigation item
    for (final item in _navigationItems) {
      routes.add(
        GoRoute(
          path: item.path,
          builder: (context, state) => item.page,
        ),
      );
    }

    // Update router configuration
    _router = GoRouter(
      initialLocation:
          _navigationItems.isNotEmpty ? _navigationItems[0].path : '/',
      routes: routes,
    );

    notifyListeners();
  }

  void addNavigationItem({
    required String label,
    required IconData icon,
    required String path,
    required Widget page,
  }) {
    _navigationItems.add(
      NavigationItem(
        label: label,
        icon: icon,
        path: path,
        page: page,
      ),
    );
    updateRoutes();
  }

  void removeNavigationItem(int index) {
    if (index >= 0 && index < _navigationItems.length) {
      _navigationItems.removeAt(index);
      if (_currentIndex >= _navigationItems.length) {
        _currentIndex =
            _navigationItems.isEmpty ? 0 : _navigationItems.length - 1;
      }
      updateRoutes();
    }
  }

  Widget getCurrentPage() {
    if (_navigationItems.isEmpty) {
      return const Center(
        child: Text('No navigation items added'),
      );
    }
    return _navigationItems[_currentIndex].page;
  }

  void navigateTo(BuildContext context, int index) {
    if (index >= 0 && index < _navigationItems.length) {
      _currentIndex = index;
      context.go(_navigationItems[index].path);
      notifyListeners();
    }
  }

  void onSideBarItemClick(int index) {
    selectedIndex = index;
    // currentPath = sideBar[index].path();
    // WebRouter.updateUrl(currentPath);

    notifyListeners();
  }

  // on side bar item hover
  void onSideBarItemHover(int index) {
    hoverIndex = index;
    notifyListeners();
  }

  // on side bar item exit
  void onSideBarItemExit(int index) {
    hoverIndex = -1;
    notifyListeners();
  }
}
