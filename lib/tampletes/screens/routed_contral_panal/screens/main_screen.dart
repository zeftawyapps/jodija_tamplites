import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sidebar_provider.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/app_drawer_widget.dart';
import '../mixins/app_shell_mixin.dart';

/// الشاشة الرئيسية مع الشريط الجانبي
class MainScreen extends StatefulWidget {
  final RouteItem routeItem;

  // خصائص من RouteItem
  late final Widget contentWidget;
  late final String appBarTitl;
  late final bool isRouteInsidebar;
  late final bool isAppBar;
  late final bool isDrawerShow;
  late final bool isAppBarLargeScreenShowTitle;
  late final bool isAppBarSmallScreenShowTitle;
  late final bool isInBottomNavBar;

  MainScreen({
    super.key,
    required this.routeItem,
  }) {
    contentWidget = routeItem.content;
    appBarTitl = routeItem.label;
    isRouteInsidebar = routeItem.isSideBarRouted;
    isAppBar = routeItem.isAppBar;
    isDrawerShow = routeItem.isDrawerShow;
    isAppBarLargeScreenShowTitle = routeItem.isDesplayTitleInLargScreen;
    isAppBarSmallScreenShowTitle = routeItem.isDesplayTitleInSmallScreen;
    isInBottomNavBar = routeItem.isInBottomNavBar;
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, AppShellMixin {
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

    // استخدام المتغيرات من المixin
    // isScreenSmall, theme, smallScreenAppBarConfig, largeScreenAppBarConfig, showAppBarOnLargeScreen
    // كلها متاحة مباشرة من المixin

    // إذا لم يكن المحتوى داخل sidebar، عرضه مباشرة
    if (!widget.isRouteInsidebar) {
      return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: _buildAppBar(context),
        body: widget.contentWidget,
      );
    }

    // تقسيم الشاشات: صغيرة أو كبيرة
    return isScreenSmall
        ? _buildSmallScreenScaffold(appShellProvider, items, selectedIndex)
        : _buildLargeScreenScaffold(items, selectedIndex);
  }

  /// Scaffold للشاشات الصغيرة
  Widget _buildSmallScreenScaffold(
    AppShellRouterProvider appShellProvider,
    List<RouteItem> items,
    int selectedIndex,
  ) {
    final itemsInBottomNavBar =
        items.where((item) => item.isInBottomNavBar).toList();
    final hasAppBar = _buildAppBar(context) != null;
    final shouldShowMenuIcon =
        !hasAppBar && (widget.isDrawerShow || widget.isRouteInsidebar);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.backgroundColor,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(
        items: items,
        selectedIndex: selectedIndex,
        isDrawerShow: widget.isDrawerShow,
        isinSideBarRoute: widget.isRouteInsidebar,
      ),
      bottomNavigationBar: itemsInBottomNavBar.length >= 2
          ? BottomNavigationBar(
              selectedItemColor: theme.selectedTextColor,
              items: itemsInBottomNavBar.map((item) {
                return BottomNavigationBarItem(
                  icon: Icon(item.icon, color: theme.iconColor),
                  label: item.label,
                );
              }).toList(),
              currentIndex: appShellProvider.selectBottomNavIndex,
              onTap: (index) {
                appShellProvider.setSelectBottomNavIndex(index);
                appShellProvider.handleItemTapByPath(
                  context,
                  itemsInBottomNavBar[index].path,
                );
              },
            )
          : null,
      body: Stack(
        children: [
          // المحتوى الرئيسي
          Container(
            color: theme.backgroundColor,
            child: widget.contentWidget,
          ),

          // أيقونة Menu العائمة في الأعلى
          if (shouldShowMenuIcon)
            Positioned(
              top: 16,
              left: layoutDirection == TextDirection.rtl ? null : 16,
              right: layoutDirection == TextDirection.rtl ? 16 : null,
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: theme.selectedIconColor,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Scaffold للشاشات الكبيرة
  Widget _buildLargeScreenScaffold(
    List<RouteItem> items,
    int selectedIndex,
  ) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: showAppBarOnLargeScreen ? _buildAppBar(context) : null,
      body: Row(
        children: [
          // الشريط الجانبي
          SidebarWidget(
            items: items,
            selectedIndex: selectedIndex,
          ),

          // الخط الفاصل
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

  Widget? _buildDrawer({
    required List<RouteItem> items,
    required int selectedIndex,
    required bool isinSideBarRoute,
    required bool isDrawerShow,
  }) {
    if (!isDrawerShow && !isinSideBarRoute) return null;
    return AppDrawerWidget(items: items, selectedIndex: selectedIndex);
  }

  AppBar? _buildAppBar(BuildContext context) {
    // إذا لا نريد عرض AppBar
    if (!widget.isAppBar) return null;

    // التحقق من عرض AppBar حسب حجم الشاشة
    if (isScreenSmall && !showAppBarOnSmallScreen) return null;
    if (!isScreenSmall && !showAppBarOnLargeScreen) return null;

    // اختيار config حسب حجم الشاشة
    final config =
        isScreenSmall ? smallScreenAppBarConfig : largeScreenAppBarConfig;
    final showTitle = isScreenSmall
        ? widget.isAppBarSmallScreenShowTitle
        : widget.isAppBarLargeScreenShowTitle;

    // إذا يوجد config، استخدمه
    if (config != null) {
      return config.buildAppBar(
        context: context,
        isAppBar: widget.isAppBar,
        currentTilte: widget.appBarTitl,
        isDesplayTitle: showTitle,
      );
    }

    // AppBar افتراضي
    return AppBar(
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
    );
  }
}
