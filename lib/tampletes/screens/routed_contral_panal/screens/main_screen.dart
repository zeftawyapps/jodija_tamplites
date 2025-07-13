import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sidebar_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/app_drawer_widget.dart';
import '../laaunser.dart';
import '../models/app_bar_config.dart';

/// الشاشة الرئيسية مع الشريط الجانبي
class MainScreen extends StatefulWidget {
  final Widget contentWidget;
  bool isRouteInsidebar = false;


    MainScreen({super.key, required this.contentWidget
  , this.isRouteInsidebar = false
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    final items = sidebarProvider.sidebarItems;
    final selectedIndex = sidebarProvider.selectedIndex;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 800;

    // Get theme from provider
    final theme = SidebarNavigationControlPanale.getTheme(context);

    // Get app bar configurations
    AppBarConfig? smallScreenAppBarConfig;
    AppBarConfig? largeScreenAppBarConfig;
    bool showAppBarOnLargeScreen = false;

    // Try to access the controlPanel to get app bar configs
    try {
      final controlPanel =
          Provider.of<SidebarNavigationControlPanale>(context, listen: false);
      smallScreenAppBarConfig = controlPanel.smallScreenAppBar;
      largeScreenAppBarConfig = controlPanel.largeScreenAppBar;
      showAppBarOnLargeScreen = controlPanel.showAppBarOnLargeScreen;
    } catch (e) {
      // If not available, use defaults
      smallScreenAppBarConfig = AppBarConfig(
        title: 'تطبيقي',
        titleStyle: TextStyle(
          fontSize: theme.fontSize * 1.4,
          fontWeight: theme.selectedFontWeight,
          color: theme.textColor,
        ),
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
      );
    }

    return Scaffold(
      backgroundColor: theme.backgroundColor,

      // Show app bar based on screen size and configuration
      appBar: isSmallScreen
          ? (smallScreenAppBarConfig?.buildAppBar(isSmallScreen: true) ??
              _buildDefaultAppBar(theme, true))
          : (showAppBarOnLargeScreen
              ? (largeScreenAppBarConfig?.buildAppBar(isSmallScreen: false) ??
                  _buildDefaultAppBar(theme, false))
              : _buildDefaultAppBar(
                  theme, false)), // Always show app bar for user info

      // إضافة درج تنقل عندما تكون الشاشة صغيرة
      drawer: isSmallScreen
          ? AppDrawerWidget(
              items: items,
              selectedIndex: selectedIndex,
            )
          : null,

      body:
   ! widget.isRouteInsidebar? widget.contentWidget :

      Row(
        children: [
          // إظهار الشريط الجانبي فقط إذا كانت الشاشة كبيرة
          if (!isSmallScreen)
            SidebarWidget(
              items: items,
              selectedIndex: selectedIndex,
            ),

          // إظهار الخط الفاصل فقط إذا كانت الشاشة كبيرة
          if (!isSmallScreen)
            Container(
              width: 1,
              color: theme.selectedBorderColor.withOpacity(0.3),
            ),

          // المحتوى الرئيسي
          Expanded(
            child: Container(
              color: theme.backgroundColor,
              child: widget.contentWidget,
            ),
          ),
        ],
      ),
    );
  }



  // Default app bar if configuration is not provided
  AppBar _buildDefaultAppBar(dynamic theme, bool isSmallScreen) {
    return AppBar(
      backgroundColor: theme.backgroundColor,
      foregroundColor: theme.textColor,
      title: Text(
        'تطبيق الشريط الجانبي',
        style: TextStyle(
          fontSize: theme.fontSize * 1.4,
          fontWeight: theme.selectedFontWeight,
          color: theme.textColor,
        ),
      ),
      // No actions for large screens
    );
  }
}
