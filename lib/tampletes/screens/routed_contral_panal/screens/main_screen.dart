import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/sidebar_provider.dart';
import '../theam/theam.dart';
import '../utiles/side_bar_navigation_router.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/app_drawer_widget.dart';
import '../laaunser.dart';
import '../models/app_bar_config.dart';

/// الشاشة الرئيسية مع الشريط الجانبي
class MainScreen extends StatefulWidget {
      Widget contentWidget =Container();
  bool isRouteInsidebar = false;
  bool isAppBar = true;
  String appBarTitl = "";
  bool isDrawerShow = false;
  bool isAppBarLargeScreenShowTitle = false;
  bool isAppBarSmallScreenShowTitle = false;
  bool isInBottomNavBar = false;
  RouteItem routeItem;
  MainScreen(
      {super.key,
      
      required this.routeItem,
 
      }) {
    this.contentWidget = routeItem.content;
    this.appBarTitl = routeItem.label;
    this.isRouteInsidebar = routeItem.isSideBarRouted;
    this.isAppBar = routeItem.isAppBar;
    this.appBarTitl = routeItem.label;
    this.isDrawerShow = routeItem.isDrawerShow;
    this.isAppBarLargeScreenShowTitle = routeItem.isDesplayTitleInLargScreen;
    this.isAppBarSmallScreenShowTitle = routeItem.isDesplayTitleInSmallScreen;
    this.isInBottomNavBar = routeItem.isInBottomNavBar ;
      }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isScreenSmall = false;
  AppBarConfig? smallScreenAppBarConfig;
  AppBarConfig? largeScreenAppBarConfig;
  bool showAppBarOnLargeScreen = false;
  SideBarNavigationTheames? theme;
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
    final appShellProvider = Provider.of<AppShellRouterProvider>(context);
    final items = appShellProvider.sidebarItems;
    final selectedIndex = appShellProvider.selectedIndex;
    final screenWidth = MediaQuery.of(context).size.width;
    final isScreen = screenWidth < 800;
    this.isScreenSmall = isScreen;
    // Get theme from provider
    this.theme = AdaptiveAppShell.getTheme(context);

    // Get app bar configurations

    // Try to access the controlPanel to get app bar configs
    try {
      final controlPanel =
          Provider.of<AdaptiveAppShell>(context, listen: false);
      smallScreenAppBarConfig = controlPanel.smallScreenAppBar;
      largeScreenAppBarConfig = controlPanel.largeScreenAppBar;
      showAppBarOnLargeScreen = controlPanel.showAppBarOnLargeScreen;
    } catch (e) {
      // If not available, use defaults
      smallScreenAppBarConfig = AppBarConfig(
        title: widget.appBarTitl,
        titleStyle: TextStyle(
          fontSize: this.theme?.fontSize,
          fontWeight: this.theme?.selectedFontWeight,
          color: this.theme?.textColor,
        ),
        backgroundColor: this.theme?.backgroundColor,
        foregroundColor: this.theme?.textColor,
      );
    }
List<RouteItem> itemsInBottomNavBar = items.where((item) => item.isInBottomNavBar).toList();  
    return Scaffold(
      backgroundColor: this.theme?.backgroundColor,

      // Show app bar based on screen size and configuration
      appBar: _buildAppBar(context), // Always show app bar for user info
      bottomNavigationBar:
      isScreenSmall && itemsInBottomNavBar.length >= 2  && widget.isRouteInsidebar  ? 
       BottomNavigationBar(
        selectedItemColor:  this.theme?.selectedTextColor,
        
        items: itemsInBottomNavBar.map((item) 
       
       {
        return   BottomNavigationBarItem(
          

          icon: Icon(item.icon , color: this.theme?.iconColor,),
          label: item.label ,
        ) ;
      }).toList(),
      currentIndex:  appShellProvider.selectBottomNavIndex,
      onTap: (index) {

        appShellProvider.setSelectBottomNavIndex(index);
        appShellProvider.handleItemTapByPath(context, itemsInBottomNavBar[index].path!);
      },):null ,
      // إضافة درج تنقل عندما تكون الشاشة صغيرة
      drawer: this.isScreenSmall
          ? _buildDrawer(
              items: items,
              selectedIndex: selectedIndex,
              isDrawerShow: widget.isDrawerShow,
              isinSideBarRoute: widget.isRouteInsidebar)
          : null,

      body: !widget.isRouteInsidebar
          ? widget.contentWidget
          : Row(
              children: [
                // إظهار الشريط الجانبي فقط إذا كانت الشاشة كبيرة
                if (!this.isScreenSmall)
                  SidebarWidget(
                    items: items,
                    selectedIndex: selectedIndex,
                  ),

                // إظهار الخط الفاصل فقط إذا كانت الشاشة كبيرة
                if (!this.isScreenSmall)
                  Container(
                    width: 1,
                    color: this.theme?.selectedBorderColor.withOpacity(0.3),
                  ),

                // المحتوى الرئيسي
                Expanded(
                  child: Container(
                    color: theme?.backgroundColor,
                    child: widget.contentWidget,
                  ),
                ),
              ],
            ),
    );
  }

  // Default app bar if configuration is not provided
  AppBar? _buildDefaultAppBar(dynamic theme) {
    return widget.isAppBar
        ? AppBar(
            backgroundColor: theme.backgroundColor,
            foregroundColor: theme.textColor,
            title: Text(
              widget.appBarTitl,
              style: TextStyle(
                fontSize: theme.fontSize * 1.4,
                fontWeight: theme.selectedFontWeight,
                color: theme.textColor,
              ),
            ),
            // No actions for large screens
          )
        : null;
  }

  Widget? _buildDrawer(
      {required List<RouteItem> items,
      required int selectedIndex,
      required bool isinSideBarRoute,
      required bool isDrawerShow}) {
    if (isDrawerShow == false && isinSideBarRoute == false) return null;

    return AppDrawerWidget(items: items, selectedIndex: selectedIndex);
  }

  AppBar? _buildAppBar(BuildContext context) {
    return isScreenSmall
        ? (this.smallScreenAppBarConfig?.buildAppBar(
                isAppBar: widget.isAppBar,
                currentTilte: widget.appBarTitl,
                isDesplayTitle: widget.isAppBarSmallScreenShowTitle) ??
            _buildDefaultAppBar(theme))
        : (showAppBarOnLargeScreen
            ? (largeScreenAppBarConfig?.buildAppBar(
                    isAppBar: widget.isAppBar,
                    currentTilte: widget.appBarTitl,
                    isDesplayTitle: widget.isAppBarLargeScreenShowTitle) ??
                _buildDefaultAppBar(theme))
            : null);
  }
}
